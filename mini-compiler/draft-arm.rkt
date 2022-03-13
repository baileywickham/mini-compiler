#lang racket

(provide draft/fun-body prepend-blocks append-blocks wrap-blocks)

(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt" "symbol.rkt")

(define easy-ops
  #hash((add . add)
        (sub . sub)
        (and . and)
        (or  . orr)
        (xor . eor)))

(define comp-ops
  #hash((sle . le)
        (sgt . gt)
        (sge . ge)
        (slt . lt)
        (eq  . eq)
        (ne  . ne)))

(define format-strings
  #hash((read    . .READ_FMT)
        (println . .PRINTLN_FMT)
        (print   . .PRINT_FMT)))

(struct ImmRange (min max))
(define imm16 (ImmRange 0 65535))
(define imm12 (ImmRange 0 4095))
(define imm13 (ImmRange -4095 4095))
(define imm8  (ImmRange 0 255))

;; MOVW 16b,
;; ADD 12b, 0-4095
;; LDR/SDR 13b -4095-4095
;; cmp is weird
;; we will assume operand2 is 8 bits
;; mov  0-65535

(define (draft/fun-body params body)
  (prepend-blocks (draft/blocks ((remove-phis*) body)) (make-param-moves params)))

;;
(define (make-param-moves params)
  (map-indexed move-parameter params))

;;
(define+ (move-parameter (cons param _) index)
  (if (< index (length arg-regs))
      (MovA #f param (list-ref arg-regs index))
      (LdrA param (StackLoc 'param index))))

;;
(define (draft/blocks blocks)
  (let-values ([(draft-blocks _) (map+fold draft/block #hash() blocks)])
    draft-blocks))

;;
(define+ (draft/block (Block id stmts) stack-env)
  (let-values ([(new-stmts new-stack-env) (map+fold draft/stmt stack-env stmts)])
    (values (Block (LabelA id) (append* new-stmts)) new-stack-env)))


(define (draft/stmt stmt stack-env)
  (match stmt
    [(AssignLL target (? AllocLL?))
     (values '() (hash-set stack-env target (StackLoc 'local (hash-count stack-env))))]
    [_ (values (draft/stmt* stmt stack-env) stack-env)]))

;;
(define (draft/stmt* stmt stack-env)
  (match stmt

    ;; Branches
    [(BrLL (IdLL id _))
     `(,(BrA #f (LabelA id)))]
    [(BrCondLL cnd (IdLL iftrue _) (IdLL iffalse _))
     (with-stmts ([arg (draft/arg cnd #f stack-env)])
       `(,(CmpA arg (ImmA 1))
         ,(BrA 'eq (LabelA iftrue))
         ,(BrA #f (LabelA iffalse))))]

    ;; Binary Ops
    [(AssignLL target (BinaryLL (? easy-op? op) _ arg1 arg2))
     (with-stmts ([new-arg1 (draft/arg arg1 #f stack-env)]
                  [new-arg2 (draft/arg arg2 imm8 stack-env)])
       `(,(OpA (hash-ref easy-ops op) target new-arg1 new-arg2)))]
    [(AssignLL target (BinaryLL 'mul _ arg1 arg2))
     (with-stmts ([new-arg1 (draft/arg arg1 #f stack-env)]
                  [new-arg2 (draft/arg arg2 #f stack-env)])
       `(,(OpA 'mul target new-arg1 new-arg2)))]
    [(AssignLL target (BinaryLL 'sdiv _ arg1 arg2))
     (draft/stmt*
      (AssignLL target (CallLL #f (IdLL '__aeabi_idiv #t)
                               (list (cons arg1 int) (cons arg2 int)) #f)) stack-env)]
    [(AssignLL target (BinaryLL (? comp-op? op) _ arg1 arg2))
     (with-stmts ([new-arg1 (draft/arg arg1 #f stack-env)]
                  [new-arg2 (draft/arg arg2 imm8 stack-env)])
       `(,(MovA #f target (ImmA 0))
         ,(CmpA new-arg1 new-arg2)
         ,(MovA (hash-ref comp-ops op) target (ImmA 1))))]

    ;; Get Elt Ptr TODO args
    [(AssignLL target (GetEltLL _ ptr index))
     (with-stmts ([arg (draft/arg (* index (/ int-size byte-size)) imm8 stack-env)])
       `(,(OpA 'add target ptr arg)))]

    ;; Cast TODO args
    [(AssignLL target (CastLL _ _ val _))
     (make-mov target val stack-env)]

    ;; Call
    [(AssignLL target (? CallLL? c))
     `(,@(draft/call c stack-env)
       ,(MovA #f target (RegA 'r0)))]
    [(? CallLL? c)
     (draft/call c stack-env)]

    ;; Load/Store
    [(AssignLL target (LoadLL _ ptr))
     (with-stmts ([ptr-arg (draft/arg ptr #f stack-env)])
       `(,(LdrA target ptr-arg)))]
    [(StoreLL _ val ptr)
     (with-stmts ([arg (draft/arg val #f stack-env)]
                  [ptr-arg (draft/arg ptr #f stack-env)])
       `(,(StrA arg ptr-arg)))]

    ;; Return
    [(ReturnLL _ (? void?)) '()]
    [(ReturnLL _ arg) (make-mov (RegA 'r0) arg stack-env)]

    ;; Misc.
    [(? MovA? mov) `(,mov)]
    [o (error "what ~e" o)]))

;;
(define+ (draft/call (CallLL _ (IdLL fn _) args _) stack-env)
  `(,@(append* (reverse (map-indexed (λ (arg i) (store-arg arg i stack-env)) args)))
    ,(BlA fn (length args))))

;;
(define+ (store-arg (cons arg _) i stack-env)
  (if (< i (length arg-regs))
      (make-mov (list-ref arg-regs i) arg stack-env)
      (with-stmts ([new-arg (draft/arg arg #f stack-env)])
        `(,(StrA new-arg (StackLoc 'arg i))))))

;;
(define (draft/arg arg imm-spec stack-env)
  (draft/arg* (draft/value arg stack-env) imm-spec))

;;
(define (make-mov target src stack-env)
  (make-mov* target (draft/value src stack-env)))

;;
(define (draft/arg* arg-val imm-spec)
  (cond
    [(not (imm? arg-val)) (values arg-val '())]
    [(and imm-spec (in-range? arg-val imm-spec)) (values arg-val '())]
    [else (let ([tmp (IdLL (make-label 't) #f)])
            (values tmp (make-mov* tmp arg-val)))]))

;;
(define (make-mov* target src-val)
  (match src-val
    [(? imm?) #:when (in-range? src-val imm16)
              `(,(MovA 'w target src-val))]
    [(? imm?)
     `(,(MovA 'w target (HalfA src-val #t))
       ,(MovA 't target (HalfA src-val #f)))]
    [_ `(,(MovA #f target src-val))]))

;;
(define (draft/value val stack-env)
  (match val
    [(? integer?) (ImmA val)]
    [(? boolean?) (ImmA (if val 1 0))]
    ['null (ImmA 0)]
    [(StringConstLL id) (CommA (hash-ref format-strings id))]
    [(IdLL id #t) (CommA id)]
    [(? IdLL?) (hash-ref stack-env val val)]))

(define (wrap-blocks before blocks after)
  (append-blocks (prepend-blocks blocks before) after))

;;
(define (prepend-blocks blocks stmts)
  (list-update
   blocks 0
   (λ+ ((Block id block-stmts)) (Block id (append stmts block-stmts)))))

;;
(define (append-blocks blocks stmts)
  (list-update
   blocks (sub1 (length blocks))
   (λ+ ((Block id block-stmts)) (Block id (append block-stmts stmts)))))

;;
(define (imm? v)
  (or (ImmA? v) (CommA? v)))

;;
(define+ (in-range? arg (ImmRange min max))
  (and (ImmA? arg) (<= (ImmA-v arg) max) (>= (ImmA-v arg) min)))

;;
(define (comp-op? op)
  (hash-has-key? comp-ops op))

;;
(define (easy-op? op)
  (hash-has-key? easy-ops op))

;; -------------------------------------------

(define (remove-phis*)
  (define phi-moves (make-hash))

  (define (remove-phis blocks)
    (map add-mvs-block (map remove-phis/block blocks)))

  (define+ (remove-phis/block (Block id stmts))
    (Block id (append-map remove-phis/stmt stmts)))

  (define (remove-phis/stmt stmt)
    (match stmt
      [(PhiLL id _ args)
       (let ([phi-id (IdLL (make-label '_phi) #f)])
         (for ([arg args])
           (match-let ([(cons (IdLL block-id _) (cons id _)) arg])
             (add-phi-move! block-id (make-mov phi-id id #hash()))))

         (make-mov id phi-id #hash()))]
      [_ (list stmt)]))

  (define (add-phi-move! block-id move)
    (hash-set! phi-moves block-id (append move (hash-ref phi-moves block-id '()))))

  (define+ (add-mvs-block (and block (Block id stmts)))
    (if (hash-has-key? phi-moves id)
        (Block id (let-values ([(before after) (split-at-right stmts 1)])
                    (append before (hash-ref phi-moves id '()) after)))
        block))

  remove-phis)

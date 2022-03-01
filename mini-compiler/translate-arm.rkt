#lang racket

(provide translate-arm)

(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt" "symbol.rkt" "allocate-registers.rkt")

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

(struct StackLoc (type index) #:transparent)

;; MOVW 16b,
;; ADD 12b, 0-4095
;; LDR/SDR 13b -4095-4095
;; cmp is weird
;; we will assume operand2 is 8 bits
;; mov  0-65535


(define+ (translate-arm (LLVM _ decs funs))
  (ARM (map translate-dec decs)
       (map translate-fun funs)))

;;
(define+ (translate-dec (GlobalLL (IdLL id _) _ _))
  (CommDecA id))

;;
(define+ (translate-fun (FunLL (IdLL id _) params _ body))
  (define var-blocks (list-update (translate-blocks body (hash)) 0
                                  (curry extend-block (make-param-moves params))))
  (match-define (cons num-colors locations) (allocate-registers var-blocks))
  (define no-phi-blocks ((remove-phis*) var-blocks))
  (define blocks (patch-stack ((sub-locations* locations) no-phi-blocks)))
  (define header (make-fun-header))
  (FunA id (list-update blocks 0 (curry extend-block header))))

;;
(define (make-fun-header)
  (list (PushA (list (RegA 'fp) (RegA 'lr)))
        (OpA 'add (RegA 'fp) (RegA 'sp) (ImmA 4))))

;;
(define (make-param-moves params)
  (map-indexed move-parameter params))

;;
(define+ (move-parameter (cons param _) index)
  (if (< index (length arg-regs))
      (MovA #f param (list-ref arg-regs index))
      (LdrA param (StackLoc 'param index))))

;;
(define (translate-blocks blocks stack-env)
  (match blocks
    ['() '()]
    [(cons block rst) (match-let ([(cons new-block new-stack-env) (translate-block block stack-env)])
                        (cons new-block (translate-blocks rst new-stack-env)))]))

;;
(define+ (translate-block (Block id stmts) stack-env)
  (let-values ([(new-stmts new-stack-env) (split-at-right (translate-stmts stmts stack-env) 1)])
    (cons (Block (LabelA id) new-stmts) (first new-stack-env))))

;;
(define (translate-stmts stmts stack-env)
  (match stmts
    ['() (list stack-env)]
    [(cons (AssignLL target (? AllocLL?)) rst)
     (translate-stmts rst (hash-set stack-env target (StackLoc 'local (hash-count stack-env))))]
    [(cons stmt rst) (append (translate-stmt stmt stack-env) (translate-stmts rst stack-env))]))

;;
(define (translate-stmt stmt stack-env)
  (match stmt
    
    ;; Branches
    [(BrLL (IdLL id _))
     (list (BrA #f (LabelA id)))]
    [(BrCondLL cnd (IdLL iftrue _) (IdLL iffalse _))
     (with-args ([arg (translate-arg cnd #f)])
       (list (CmpA arg (ImmA 1))
             (BrA 'eq (LabelA iftrue))
             (BrA #f (LabelA iffalse))))]
    
    ;; Binary Ops
    [(AssignLL target (BinaryLL (? easy-op? op) _ arg1 arg2))
     (with-args ([new-arg1 (translate-arg arg1 #f)]
                 [new-arg2 (translate-arg arg2 imm12)])
       (list (OpA (hash-ref easy-ops op) target new-arg1 new-arg2)))]
    [(AssignLL target (BinaryLL 'mul _ arg1 arg2))
     (with-args ([new-arg1 (translate-arg arg1 #f)]
                 [new-arg2 (translate-arg arg2 #f)])
       (list (OpA 'mul target new-arg1 new-arg2)))]
    [(AssignLL target (BinaryLL 'sdiv _ arg1 arg2))
     (translate-stmt (AssignLL target (CallLL #f (IdLL '__aeabi_idiv #t)
                                              (list (cons arg1 int) (cons arg2 int)) #f)) stack-env)]
    [(AssignLL target (BinaryLL (? comp-op? op) _ arg1 arg2))
     (with-args ([new-arg1 (translate-arg arg1 #f)]
                 [new-arg2 (translate-arg arg2 imm8)])
       (list (MovA #f target (ImmA 0))
             (CmpA new-arg1 new-arg2)
             (MovA (hash-ref comp-ops op) target (ImmA 1))))]
    
    ;; Get Elt Ptr TODO args
    [(AssignLL target (GetEltLL _ ptr 0))
     (make-mov #f target ptr)]
    [(AssignLL target (GetEltLL _ ptr index))
     (with-args ([arg (translate-arg (* index (/ int-size byte-size)) imm12)])
       (list (OpA 'add target ptr arg)))]
    
    ;; Cast TODO args
    [(AssignLL target (CastLL _ _ val _))
     (make-mov #f target val)]
    
    ;; Call
    [(AssignLL target (? CallLL? c))
     (append (translate-call c)
             (list (MovA #f target (RegA 'r0))))]
    [(? CallLL? c) (translate-call c)]
    
    ;; Load/Store
    [(AssignLL target (LoadLL _ ptr))
     (with-args ([ptr-arg (translate-arg ptr #f)])
       (list (LdrA target (hash-ref stack-env ptr ptr-arg))))]
    [(StoreLL _ val ptr)
     (with-args ([arg (translate-arg val #f)]
                 [ptr-arg (translate-arg ptr #f)])
       (list (StrA arg (hash-ref stack-env ptr ptr-arg))))]
    
    ;; Return
    [(ReturnLL _ (? void?))
     (list (PopA (list (RegA 'fp) (RegA 'pc))))]
    [(ReturnLL _ arg)
     (append (make-mov #f (RegA 'r0) arg)
             (list (PopA (list (RegA 'fp) (RegA 'pc)))))]
    [o (list o)]))

;;
(define+ (translate-call (CallLL _ (IdLL fn _) args _))
  (define new-args (append* (reverse (map-indexed store-arg args))))
  (append new-args (list (BlA fn (length args)))))

;;
(define+ (store-arg (cons arg _) i)
  (if (< i (length arg-regs))
      (make-mov #f (list-ref arg-regs i) arg)
      (with-args ([new-arg (translate-arg arg #f)])
        (list (StrA new-arg (StackLoc 'arg i))))))

(define (translate-arg arg imm-spec)
  (define arg-val (translate-value arg))
  (cond
    [(not (imm? arg-val)) (values arg-val '())]
    [(and imm-spec (in-range? arg-val imm-spec)) (values arg-val '())]
    [else (let ([tmp (IdLL (make-label 't) #f)])
            (values tmp (make-mov 'w tmp arg)))]))

(define (make-mov pred target src)
  (define src-val (translate-value src))
  (match src-val
    [(? imm?)
     #:when (in-range? src-val imm16)
     (list (MovA (or pred 'w) target src-val))]
    [(? imm?)
     (when (and pred (not (equal? pred 'w))) (error "pred error"))
     (list (MovA 'w target (HalfA src-val #t))
           (MovA 't target (HalfA src-val #f)))]
    [_ (list (MovA pred target src-val))]))

(define (translate-value val)
  (match val
    [(? integer?) (ImmA val)]
    [(? boolean?) (ImmA (if val 1 0))]
    [(StringConstLL id) (CommA (hash-ref format-strings id))]
    [(IdLL id #t) (CommA id)]
    [(? IdLL?) val]))

(define+ (extend-block stmts (Block id block-stmts))
  (Block id (append stmts block-stmts)))

(define (imm? v)
  (or (ImmA? v) (CommA? v)))

(define+ (in-range? arg (ImmRange min max))
  (and (ImmA? arg) (<= (ImmA-v arg) max) (>= (ImmA-v arg) min)))

(define (comp-op? op)
  (hash-has-key? comp-ops op))

(define (easy-op? op)
  (hash-has-key? easy-ops op))


;; ------------------------------------------------

(define (remove-phis*)
  (define phi-moves (make-hash))

  (define (remove-phis blocks)
    (map add-mvs-block (map remove-phis-block blocks)))

  (define+ (remove-phis-block (Block id stmts))
    (Block id (map remove-phis-stmt stmts)))

  (define (remove-phis-stmt stmt)
    (match stmt
      [(PhiLL id _ args)
       (let ([phi-id (IdLL (make-label '_phi) #f)])
         (for ([arg args])
           (match-let ([(cons block-id (cons id _)) arg])
             (add-phi-move! block-id (AssignLL phi-id id))))
         ; might not both be registers
         (MovA #f id phi-id))]
      [_ stmt]))

  (define (add-phi-move! block-id move)
    (hash-set! phi-moves block-id (cons move (hash-ref phi-moves block-id '()))))

  (define+ (add-mvs-block (Block id stmts))
    (Block id (let-values ([(before after) (split-at-right stmts 1)])
                (append before (hash-ref phi-moves id '()) after))))

  remove-phis)

(define (sub-locations* locations)

  (define (sub-locations/blocks blocks)
    (map sub-locations/block blocks))

  (define+ (sub-locations/block (Block id stmts))
    (Block id (map sub-locations/stmt stmts)))

  (define (sub-locations/stmt stmt)
    (match stmt
      [(OpA op target r1 op2) (OpA op (get-location target) (get-location r1) (get-location op2))]
      [(CmpA r1 op2) (CmpA (get-location r1) (get-location op2))]
      [(MovA op r1 op2) (MovA op (get-location r1) (get-location op2))]
      [(LdrA r1 addr) (LdrA (get-location r1) (get-location addr))]
      [(StrA r1 addr) (StrA (get-location r1) (get-location addr))]
      [_ stmt]))

  (define (get-location op)
    (if (IdLL? op)
        (hash-ref locations op (RegA 'r0))
        op))

  sub-locations/blocks)

; two passes, one to gather stack locations/offsets, one to resolve them

(define (patch-stack blocks)
  (define locs (remove-duplicates (append-map get-stack-locs blocks)))
  (pretty-display locs)
  blocks)

(define+ (get-stack-locs (Block _ stmts))
  (filter-map get-stack-locs/stmt stmts))

(define (get-stack-locs/stmt stmt)
  (match stmt
    [(StrA _ (? StackLoc? addr)) addr]
    [(LdrA _ (? StackLoc? addr)) addr]
    [_ #f]))


;;--------------------------------------------

(define-syntax (with-args syntax-object)
  (syntax-case syntax-object ()
    [(_ ([arg exp] ...) body ...)
     (with-syntax ([(stmts ...) (generate-temporaries #'(arg ...))])
       #'(let-values ([(arg stmts) exp] ...)
           (append stmts ... (begin body ...))))]))




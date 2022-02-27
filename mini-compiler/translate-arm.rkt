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

(define+ (translate-dec (GlobalLL (IdLL id _) _ _))
  (CommA id))

(define+ (translate-fun (FunLL (IdLL id _) params _ body))
  (define header (make-fun-header params))
  (define var-blocks (translate-blocks body (hash)))
  (match-define (cons num-colors locations) (allocate-registers var-blocks))
  (define no-phi-blocks ((remove-phis*) var-blocks))
  (define blocks (patch-stack ((sub-locations* locations) no-phi-blocks)))
  (FunA id (list-update blocks 0 (curry extend-block header))))

(define (make-fun-header params)
  (append (list (PushA (list (RegA 'fp) (RegA 'lr)))
                (OpA 'add (RegA 'fp) (RegA 'sp) 4))
          (map-indexed move-parameter params)))

(define+  (move-parameter (cons param _) index)
  (if (< index (length arg-regs))
      (MovA #f param (list-ref arg-regs index))
      (LdrA param (OffsetA (RegA 'fp) (* 4 (add1 (- index (length arg-regs))))))))

(define (translate-blocks blocks stack-env)
  (match blocks
    ['() '()]
    [(cons block rst) (match-let ([(cons new-block new-stack-env) (translate-block block stack-env)])
                        (cons new-block (translate-blocks rst new-stack-env)))]))

(define+ (translate-block (Block id stmts) stack-env)
  (let-values ([(new-stmts new-stack-env) (split-at-right (translate-stmts stmts stack-env) 1)])
    (cons (Block (LabelA id) new-stmts) (first new-stack-env))))

(define (translate-stmts stmts stack-env)
  (match stmts
    ['() (list stack-env)]
    [(cons (AssignLL target (? AllocLL?)) rst)
     (translate-stmts rst (hash-set stack-env target (StackLoc 'local (hash-count stack-env))))]
    [(cons stmt rst) (append (translate-stmt stmt stack-env) (translate-stmts rst stack-env))]))
         

(define (translate-stmt stmt stack-env)
  (match stmt
    [(BrLL (IdLL id _))
     (list (BrA #f (LabelA id)))]
    [(BrCondLL cond (IdLL iftrue _) (IdLL iffalse _))
     (match-let ([(cons arg stmts) (translate-arg cond #f)])
       (append stmts
               (list (CmpA arg 1)
                     (BrA 'eq (LabelA iftrue))
                     (BrA #f (LabelA iffalse)))))]
    [(AssignLL target (? IdLL? src))
     (make-mov #f target src)]
    [(AssignLL target (BinaryLL (? easy-op? op) _ arg1 arg2))
     (match-let ([(cons new-arg1 stmts1) (translate-arg arg1 #f)]
                 [(cons new-arg2 stmts2) (translate-arg arg2 imm12)])
       (append stmts1 stmts2
               (list (OpA (hash-ref easy-ops op) target new-arg1 new-arg2))))]
    [(AssignLL target (BinaryLL 'mul _ arg1 arg2))
     (match-let ([(cons new-arg1 stmts1) (translate-arg arg1 #f)]
                 [(cons new-arg2 stmts2) (translate-arg arg2 #f)])
       (append stmts1 stmts2  
               (list (OpA 'mul target new-arg1 new-arg2))))]
    [(AssignLL target (GetEltLL _ ptr 0))
     (make-mov #f target ptr)]
    [(AssignLL target (GetEltLL _ ptr index))
     (match-let ([(cons arg stmts) (translate-arg (* index (/ int-size byte-size)) imm12)])
       (append stmts
               (list (OpA 'add target ptr arg))))]
    [(AssignLL target (CastLL _ _ val _))
     (make-mov #f target val)]
    [(AssignLL target (BinaryLL 'sdiv _ arg1 arg2))
     (translate-stmt (AssignLL target (CallLL #f (IdLL '__aeabi_idiv #t)
                                              (list (cons arg1 int) (cons arg2 int)) #f)))]
    [(StoreLL _ val ptr)
     (match-let ([(cons arg stmts) (translate-arg val #f)])
       (append stmts
               (list (StrA arg (hash-ref stack-env ptr ptr)))))]
    [(AssignLL target (BinaryLL (? comp-op? op) _ arg1 arg2))
     (match-let ([(cons new-arg1 stmts1) (translate-arg arg1 #f)]
                 [(cons new-arg2 stmts2) (translate-arg arg2 imm8)])
       (append stmts1 stmts2  
               (list (MovA #f target 0)
                     (CmpA new-arg1 new-arg2)
                     (MovA (hash-ref comp-ops op) target 1))))]
    [(AssignLL target (? CallLL? c))
     (append (translate-call c)
             (list (MovA #f target (RegA 'r0))))]
    [(? CallLL? c) (translate-call c)]
    [(AssignLL target (LoadLL _ (IdLL id #t)))
     ; Globals
     (append (make-mov #f target (LabelA id))
             (list (LdrA target target)))]
    [(AssignLL target (LoadLL _ ptr))
     (list (LdrA target (hash-ref stack-env ptr ptr)))]
    [(ReturnLL _ (? void?))
     (list (PopA (list (RegA 'fp) (RegA 'pc))))]
    [(ReturnLL _ arg)
     (append (make-mov #f (RegA 'r0) arg)
             (list (PopA (list (RegA 'fp) (RegA 'pc)))))]
    [o (list o)]))

(define+ (translate-call (CallLL _ (IdLL fn _) args _))
  (define new-args (append* (reverse (map-indexed store-arg args))))
  (append new-args (list (BrA 'l fn))))

(define+ (store-arg (cons arg _) i)
  (if (< i (length arg-regs))
      (make-mov #f (list-ref arg-regs i) arg)
      (match-let ([(cons new-arg stmts) (translate-arg arg #f)])
       (append stmts
               (list (StrA new-arg (StackLoc 'arg i)))))))

(define (translate-arg arg imm-spec)
  (cond
    [(not (imm? arg)) (cons arg '())]
    [(and imm-spec (in-range? arg imm-spec)) (cons arg '())]
    [else (let ([tmp (IdLL (make-label 't) #f)])
            (cons tmp (make-mov 'w tmp arg)))]))

(define (make-mov pred target src)
  (match src
    [(? imm?)
     #:when (in-range? src imm16)
     (list (MovA (or pred 'w) target src))]
    [(? imm?)
     (when pred (error "pred error"))
     (list (MovA 'w target (HalfA src #t))
           (MovA 't target (HalfA src #f)))]
    [_ (list (MovA pred target src))]))

(define+ (extend-block stmts (Block id block-stmts))
  (Block id (append stmts block-stmts)))

(define imm? (disjoin integer? StringConstLL? LabelA?))

(define+ (in-range? arg (ImmRange min max))
  (and (integer? arg) (<= arg max) (>= arg min)))

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
  (define locs (list->set (append-map get-stack-locs blocks)))
  (pretty-display locs)
  blocks)

(define+ (get-stack-locs (Block _ stmts))
  (append-map get-stack-locs/stmt stmts))

(define (get-stack-locs/stmt stmt)
  (match stmt
    [(StrA _ (? StackLoc? addr)) (list addr)]
    [(LdrA _ (? StackLoc? addr)) (list addr)]
    [o '()]))
                         
  
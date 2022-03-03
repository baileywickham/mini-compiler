#lang racket

(provide translate-arm)

(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt" "symbol.rkt"
         "allocate-registers.rkt" "draft-arm.rkt" "cleanup-arm.rkt")


;;
(define fun-header
  `(,(PushA (list (RegA 'fp) (RegA 'lr)))
    ,(OpA 'add (RegA 'fp) (RegA 'sp) (ImmA 4))))

;;
(define fun-footer
  `(,(PopA (list (RegA 'fp) (RegA 'pc)))))


;;
(define+ (translate-arm (LLVM _ decs funs))
  (ARM (map translate-dec decs)
       (map translate-fun funs)))

;;
(define+ (translate-dec (GlobalLL (IdLL id #t) _ _))
  (CommDecA id))

;;
(define+ (translate-fun (FunLL (IdLL id #t) params _ body))
  (define draft-blocks (draft/fun-body params body))
  (match-define (cons num-colors locations) (allocate-registers draft-blocks))
  (define blocks (patch-stack ((sub-locations* locations) draft-blocks)))
  (define callee-saves (get-saves num-colors))
  (FunA id (cleanup-arm/blocks (wrap-blocks
            fun-header
            (wrap-blocks (list (PushA callee-saves)) blocks (list (PopA callee-saves)))
            fun-footer))))

(define (get-saves num-colors)
  (take callee-saved-regs
        (min (- num-colors (length arg-regs)) (length callee-saved-regs))))


;; ------------------------------------------------

;; -------------------------------------------

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
  (define-values (size stack-assignment) (get-stack-assignment locs))
  (wrap-blocks (list (OpA 'sub (RegA 'sp) (RegA 'sp) (ImmA size)))
               ((subst-stack stack-assignment) blocks)
               (list (OpA 'add (RegA 'sp) (RegA 'sp) (ImmA size)))))


(define+ (get-stack-locs (Block _ stmts))
  (filter-map get-stack-locs/stmt stmts))

(define (get-stack-locs/stmt stmt)
  (match stmt
    [(StrA _ (? StackLoc? addr)) addr]
    [(LdrA _ (? StackLoc? addr)) addr]
    [(MovA _ _ (? StackLoc? addr)) addr]
    [_ #f]))

(define (get-stack-assignment locs)
  (define stack-frame (append
                       (get-locs locs 'arg)
                       (get-locs locs 'spill)
                       (get-locs locs 'temp)
                       (get-locs locs 'local)))
  (define stack-size (* (length stack-frame) 4))
  (define params (get-locs locs 'param))
  (values stack-size
          (make-immutable-hash
           (append
            (map-indexed (λ (loc i) (cons loc (OffsetA (RegA 'sp) (ImmA (* i 4))))) stack-frame)
            (map-indexed (λ (loc i) (cons loc (OffsetA (RegA 'fp) (ImmA (* (add1 i) 4))))) params)))))

(define (get-locs locs type)
  (sort (filter (λ (loc) (equal? type (StackLoc-type loc))) locs)
        < #:key StackLoc-index))

(define (subst-stack stack-assignment)
  (define (subst-stack/blocks blocks)
    (map subst-stack/block blocks))
  
  (define+ (subst-stack/block (Block id stmts))
    (Block id (map subst-stack/stmt stmts)))

  (define (subst-stack/stmt stmt)
    (match stmt
      [(StrA target (? StackLoc? addr)) (StrA target (hash-ref stack-assignment addr))]
      [(LdrA target (? StackLoc? addr)) (LdrA target (hash-ref stack-assignment addr))]
      [(MovA pred target (? StackLoc? addr))
       (when pred (error "Can't handle pred"))
       (match-let ([(OffsetA reg offset) (hash-ref stack-assignment addr)])
         (OpA 'add target reg offset))]
      [_ stmt]))

  subst-stack/blocks)

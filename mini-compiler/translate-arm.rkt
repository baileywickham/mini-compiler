#lang racket

(provide translate-arm)

(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt" "symbol.rkt"
         "allocate-registers.rkt" "draft-arm.rkt" )


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
  (define no-phi-blocks ((remove-phis*) draft-blocks))
  (define blocks (patch-stack ((sub-locations* locations) no-phi-blocks)))
  (define header (make-fun-header))
  (FunA id (list-update blocks 0 (curry extend-block header))))

;;
(define (make-fun-header)
  (list (PushA (list (RegA 'fp) (RegA 'lr)))
        (OpA 'add (RegA 'fp) (RegA 'sp) (ImmA 4))))

;;
(define (make-fun-footer)
  (list (PopA (list (RegA 'fp) (RegA 'pc)))))

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
           (match-let ([(cons id block-id) arg])
             (add-phi-move! block-id (MovA #f phi-id id))))
         ; might not both be registers
         (MovA #f id phi-id))]
      [_ stmt]))

  (define (add-phi-move! block-id move)
    (hash-set! phi-moves block-id (cons move (hash-ref phi-moves block-id '()))))

  (define+ (add-mvs-block (Block id stmts))
    (Block id (let-values ([(before after) (split-at-right stmts 1)])
                (append before (hash-ref phi-moves id '()) after))))

  remove-phis)

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
  ;(pretty-display stack-assignment)
  (list-update ((subst-stack stack-assignment) blocks)
               0
               (curry extend-block (list (OpA 'add (RegA 'sp) (RegA 'sp) (ImmA size))))))

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
            (map-indexed (lambda (loc i) (cons loc (OffsetA (RegA 'sp) (ImmA (* i 4))))) stack-frame)
            (map-indexed (lambda (loc i) (cons loc (OffsetA (RegA 'fp) (ImmA (* (add1 i) 4))))) params)))))

(define (get-locs locs type)
  (sort (filter (lambda (loc) (equal? type (StackLoc-type loc))) locs)
        <
        #:key StackLoc-index))

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

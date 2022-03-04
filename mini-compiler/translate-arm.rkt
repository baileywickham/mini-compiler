#lang racket

(provide translate-arm)

(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt"
         "allocate-registers.rkt" "draft-arm.rkt" "cleanup-arm.rkt")

(define tmp1 (first spill-temps))
(define tmp2 (second spill-temps))

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
  (define-values (num-colors locations) (allocate-registers draft-blocks))
  (define blocks (patch-stack ((sub-locations* locations) draft-blocks)))
  (define callee-saves (get-saves num-colors))
  (FunA id (cleanup-arm/blocks
            (wrap-blocks
             (fun-header callee-saves)
             blocks 
             (fun-footer callee-saves)))))

;;
(define (fun-header callee-saves)
  `(,(PushA (list (RegA 'fp) (RegA 'lr)))
    ,(OpA 'add (RegA 'fp) (RegA 'sp) (ImmA 4))
    ,(PushA callee-saves)))

;;
(define (fun-footer callee-saves)
  `(,(PopA callee-saves)
    ,(PopA (list (RegA 'fp) (RegA 'pc)))))

;;
(define (get-saves num-colors)
  (take callee-saved-regs
        (min (- num-colors (length arg-regs)) (length callee-saved-regs))))

;; -------------------------------------------

(define (sub-locations* locations)

  (define (sub-locations/blocks blocks)
    (map sub-locations/block blocks))

  (define+ (sub-locations/block (Block id stmts))
    (Block id (append-map sub-locations/stmt stmts)))

  (define (sub-locations/stmt stmt)
    (match stmt
      [(OpA op target r1 op2)
       (with-stmts ([^ new-target (get-location target tmp1 #t)]
                    [arg1 (get-location r1 tmp1 #f)]
                    [arg2 (get-location op2 tmp2 #f)])
         (if (void? new-target) '()
             `(,(OpA op new-target arg1 arg2))))]
      [(CmpA r1 op2) 
       (with-stmts ([arg1 (get-location r1 tmp1 #f)]
                    [arg2 (get-location op2 tmp2 #f)])
         `(,(CmpA arg1 arg2)))]
      [(MovA op r1 op2) 
       (with-stmts ([^ arg1 (get-location r1 tmp1 #t)]
                    [arg2 (get-location op2 tmp1 #f)])
         (if (void? arg1) '()
             `(,(MovA op arg1 arg2))))]
      [(LdrA r1 addr) 
       (with-stmts ([^ arg1 (get-location r1 tmp1 #t)]
                    [arg2 (get-location addr tmp2 #f)])
         (if (void? arg1) '()
             `(,(LdrA arg1 arg2))))]
      [(StrA r1 addr) 
       (with-stmts ([arg1 (get-location r1 tmp1 #f)]
                    [arg2 (get-location addr tmp2 #f)])
         `(,(StrA arg1 arg2)))]
      [_ `(,stmt)]))

  (define (get-location op tmp write?)
    (if (IdLL? op)
        (match (hash-ref locations op (void))
          [(? RegA? r) (values r '())]
          [(? StackLoc? s)
           (values
            tmp
            (list (if write? (StrA tmp s) (LdrA tmp s))))]
          [(? void?) (values (void) '())])
        (values op '())))

  sub-locations/blocks)

; two passes, one to gather stack locations/offsets, one to resolve them

(define (patch-stack blocks)
  (define locs (remove-duplicates (append-map get-stack-locs blocks)))
  (define-values (size stack-assignment) (get-stack-assignment locs))
  (wrap-blocks `(,(OpA 'sub (RegA 'sp) (RegA 'sp) (ImmA size)))
               ((subst-stack stack-assignment) blocks)
               `(,(OpA 'add (RegA 'sp) (RegA 'sp) (ImmA size)))))


(define+ (get-stack-locs (Block _ stmts))
  (filter-map get-stack-locs/stmt stmts))

(define (get-stack-locs/stmt stmt)
  (match stmt
    [(StrA _ (? StackLoc? addr)) addr]
    [(LdrA _ (? StackLoc? addr)) addr]
    [(MovA _ _ (? StackLoc? addr)) addr]
    [_ #f]))

(define (get-stack-assignment locs)
  (let ([stack-frame (append (get-locs locs 'arg) (get-locs locs 'spill)
                             (get-locs locs 'temp) (get-locs locs 'local))]
        [params (get-locs locs 'param)])
    (values
     (* (length stack-frame) 4)
     (make-immutable-hash
      (append
       (map-indexed (λ (loc i) (cons loc (OffsetA (RegA 'sp) (ImmA (* i 4))))) stack-frame)
       (map-indexed (λ (loc i) (cons loc (OffsetA (RegA 'fp) (ImmA (* (add1 i) 4))))) params))))))

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

#lang racket

(require "ast.rkt")
(require "util.rkt")
(require "symbol.rkt")
(provide convert-ssa)


(struct Phi (block) #:transparent)


; Context: current-def (hash vars -> (hash block-id -> block))
; incomplete-phis (hash block-id (hash vars Phi))
; sealed-blocks (set block-id)

(define+ (convert-ssa (Mini types decs funs))
  (Mini types decs (map fun-ssa funs)))

(define+ (fun-ssa (Fun id params ret-type decs body))
  (pretty-display (compute-preds body))
  (define block (first body))
  (define current-def (make-hash
                       (map (λ (p) (cons (car p)
                                         (make-hash (list (cons (Block*-id block) (car p))))))
                            params)))
  (displayln current-def)
  (define incomplete-phis (make-hash))
  (define sealed-blocks (set))

  (displayln (map (λ (s) (stmt-ssa s (Block*-id block)
                                   (list current-def incomplete-phis sealed-blocks)))
                  (Block*-stmts block))))

(define (compute-preds blocks)
  (define cfg (make-hash))
  (for ([block blocks])
    (hash-ref! cfg (Block*-id block) (Block-ssa (Block*-id block) '() '() '()))
    (define sucs (get-next block))
    (for ([suc sucs])
      (define b (hash-ref! cfg suc (Block-ssa suc '() '() '())))
      (set-Block-ssa-preds! b (cons (Block*-id block) (Block-ssa-preds b)))))
  cfg)
      

(define (get-next block)
  (match (last (Block*-stmts block))
    [(GotoCond* _ L1 L2) (list L1 L2)]
    [(Goto* L1) (list L1)]
    [_ '()]))
    
    

(define+ (stmt-ssa stmt block-id context)
  (match stmt
    [(Assign target src)
     (let ([new-src (exp-ssa src block-id context)]
           [new-target (make-label '_u)])
       (write-var target block-id new-target context)
       (Assign new-target new-src))]
    [(Return exp) (Return (exp-ssa exp block-id context))]
    [(Delete exp) (Delete (exp-ssa exp block-id context))]
    [(Print exp endl?) (Print (exp-ssa exp block-id context) endl?)]
    [(Inv id args) (Inv id (map (λ (exp) (exp-ssa exp block-id context)) args))]
    [(GotoCond* cond iftrue iffalse) (GotoCond* (exp-ssa cond block-id context) iftrue iffalse)]
    [_ stmt]))

(define+ (exp-ssa exp block-id context)
  (match exp
    [(Prim op exps) (Prim op (map (λ (exp) (exp-ssa exp block-id context)) exps))]
    [(? symbol?) (read-var exp block-id context)]
    [(Dot left id) (Dot (exp-ssa left block-id context) id)]
    [(Inv id args) (Inv id (map (λ (exp) (exp-ssa exp block-id context)) args))]
    [_ exp]))

;; Given a var orginial name, the block id, and the value, updates current-def
;; returns void
(define+ (write-var var block val (and context (list current-def _ _)))
  (hash-set! (hash-ref! current-def var (make-hash)) block val))

;; Given a var original name, and the block id, returns a value that will serve as an
;; argument, something like an id or a number
(define+ (read-var var block (and context (list current-def _ _)))
  (if (hash-has-key? (hash-ref current-def var) block)
      (hash-ref (hash-ref current-def var) block)
      (read-var-from-pred var block context)))

(define (Block-preds b) '())

;; returns a value that will serve as an argument, something like an id or a number
(define+ (read-var-from-pred var block
                             (and context (list current-def incomplete-phis sealed-blocks)))
  (define val
    (cond
      [(not (set-member? sealed-blocks block))
       ;; this CFG is not complete, the block might gain a predecessor
       ;; thus the need for a phi is unclear, so let’s assume it is needed
       (define p (Phi block))
       (hash-set! (hash-ref incomplete-phis block) var p)
       p]
      [(empty? (Block-preds block))
       (error 'ssa "undefined ~a" var)]
      [(empty? (rest (Block-preds block)))
       ;; there is only one predecessor (and the block is sealed)
       (read-var var (first (Block-preds block)))]
      [else
       ;; ok, let’s search through predecessors and join them
       ;; with a phi instruction at the beginning of this block
       (define p (Phi block))
       (write-var var block p) ;; variable maps to new value breaks cycles
       ;;^^^^^^^^ differs from paper, return value not used, so last
       ;; writeVariable is redundant along this path
       (add-phi-operands var p)
       p]))
  (write-var var block val) ;; variable maps to value
  val)

;;
(define+ (add-phi-operands var phi (and context (list _ _ _)))
  (for ([pred (Block-preds (Phi-block phi))])
    (phi-append-operand phi (read-var var pred context))))

;;
(define+ (seal-block block (and context (list current-def incomplete-phis sealed-blocks)))
  ;; get target variables of all incomplete phis in this block
  (for ([var (hash-ref incomplete-phis block)])
    ;; for each variable, fill phi based on predecessors
    (add-phi-operands var (hash-ref (hash-ref incomplete-phis block) var) context))
  (set-add sealed-blocks block))


(define (phi-append-operand phi val) '())

#;(define (remove-trivial-phis cfg)
    (define phis (gather-all-phis cfg))
    (define-values (trival working-set) (split-trivial phis)))


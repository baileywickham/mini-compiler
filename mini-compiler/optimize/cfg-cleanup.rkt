#lang racket

(provide simplify-cfg)

(require graph "common.rkt")

;;
(define+ (simplify-cfg (LLVM ty decs funs))
  (LLVM ty decs (map simplify/fun funs)))

;;
(define+ (simplify/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (simplify/blocks body)))

;;
(define (simplify/blocks blocks)
  (define cfg (build-graph blocks))
  (define block-content
    (make-immutable-hash
     (map (λ (block) (cons (Block-id block) block)) blocks)))
  (define merges (get-merges blocks cfg))

  (apply-merges blocks merges block-content))

(define+ (get-dead-blocks blocks (cons succs preds))
  (filter-map (λ+ ((Block id _)) (if (empty? (get-neighbors preds id)) id #f)) (rest blocks)))

(define+ (get-merges blocks (cons succs preds))
  (filter-map
   (λ+ ((Block id _))
       (let ([preds (get-neighbors preds id)])
         (cond
           [(and
             (= (length preds) 1)
             (= (length (get-neighbors succs (first preds))) 1))
            (cons (first preds) id)]
           [else #f]))) blocks))

(define (apply-merges blocks merges block-content)
  (define merge-into (make-immutable-hash merges))
  (define new-ends (make-immutable-hash (map (λ+ ((cons a b)) (cons b a)) merges)))
  (define draft-merged
    (filter-map (λ (block) (draft-merges/block block merge-into block-content #t)) blocks))
  ((rewrite-phis* new-ends) draft-merged))

(define+ (draft-merges/block (and block (Block id stmts)) merges block-content top)
  (cond
    [(and top (member id (hash-values merges))) #f]
    [(hash-has-key? merges id)
     (match-let
         ([(Block _ append-stmts)
           (draft-merges/block (hash-ref block-content (hash-ref merges id))
                               merges block-content #f)])
       (Block id (append (drop-right stmts 1) append-stmts)))]
    [else block]))

(define (rewrite-phis* new-ends)

  (define (rewrite-phis/blocks blocks)
    (map rewrite-phis/block blocks))

  (define+ (rewrite-phis/block (Block id stmts))
    (Block id (map rewrite-phis/stmt stmts)))

  (define (rewrite-phis/stmt stmt)
    (match stmt
      [(PhiLL id ty args)
       (PhiLL id ty
              (map (λ+ ((cons (IdLL label global?) id))
                       (cons (IdLL (rewrite-phis/label label) global?) id)) args))]
      [_ stmt]))

  (define (rewrite-phis/label label)
    (if (hash-has-key? new-ends label)
        (rewrite-phis/label (hash-ref new-ends label))
        label))

  rewrite-phis/blocks)

;;
(define (build-graph blocks)
  (define edges (append-map get-next blocks))
  ;(display edges)
  (cons (unweighted-graph/directed edges)
        (unweighted-graph/directed (map flip-edge edges))))

;;
(define+ (get-next (Block id stmts))
  (match (last stmts)
    [(BrLL (IdLL next-id _)) (list id (list id next-id))]
    [(BrCondLL _ (IdLL iftrue _) (IdLL iffalse _))
     (list id (list id iftrue) (list id iffalse))]
    [(? ReturnLL?) (list id)]))

;;
(define+ (flip-edge v)
  (match v
    [(list a b) (list b a)]
    [_ v]))



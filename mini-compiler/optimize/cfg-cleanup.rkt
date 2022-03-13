#lang racket

(require graph "common.rkt")

(define+ (simplify-cfg (LLVM ty decs funs))
  (LLVM ty decs (map simplify/fun funs)))

(define+ (simplify/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (simplify/blocks body)))

(define (simplify/blocks blocks)
  (define cfg (build-graph blocks))
  blocks)


(define (build-graph blocks)
  (define edges (append-map get-next blocks))
  (cons (unweighted-graph/directed edges)
        (unweighted-graph/directed (map flip-cons edges))))

(define+ (get-next (Block id stmts))
  (match (last stmts)
    [(BrLL (IdLL next-id _)) (list (cons id next-id))]
    [(BrCondLL _ (IdLL iftrue _) (IdLL iffalse _))
     (list (cons id iftrue) (cons id iffalse))]
    [(? ReturnLL?) '()]))

(define+ (flip-cons (cons a b))
  (cons b a))

  
  
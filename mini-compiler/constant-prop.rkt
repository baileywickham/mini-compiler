#lang racket

(require "optimize-common.rkt")
(provide constant-prop)

(define op-procs (hash 'add +
                       'mul *
                       'sub -
                       'sdiv quotient
                       'and (lambda (a b) (and a b))
                       'or (lambda (a b) (or a b))
                       'eq equal?
                       'sle <=
                       'sgt >
                       'sge >=
                       'slt <
                       'ne (negate equal?)))

(define+ (constant-prop (LLVM tys decs funs))
  (LLVM tys decs (map prop/fun funs)))

(define+ (prop/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (prop/body body)))

(define (prop/body blocks)
  (define vals (initial-vals blocks))
  (define worklist
    (filter identity
            (hash-map vals (lambda (id v) (if (not (equal? v 'T)) id #f)))))
  (define use-graph (get-uses blocks))
  (define final-values (get-vals worklist vals use-graph))
  (displayln "final vals")
  (pretty-display final-values)
  blocks)

(define (get-vals worklist vals use-graph)
  (displayln "getvals")
  (pretty-display worklist)
  (if (empty? worklist)
      vals
      (let ([new-worklist (update-vals (first worklist) (rest worklist) vals use-graph)])
        (get-vals new-worklist vals use-graph))))

(define (update-vals r worklist vals use-graph)
  (define ops (hash-ref use-graph r '()))
  (pretty-display ops)
  (define update-worklist
    (filter-map
     (lambda (op)
       (match (stmt-writes op)
         ['() #f]
         [(list m)
          (define val-m (hash-ref vals m))
          (cond
            [(equal? val-m 'L) #f]
            [else
             (let ([m-eval (evaluate op vals)])
               (pretty-display m-eval)
               (hash-set! vals m m-eval)
               (if (equal? m-eval val-m) #f m))])]))
     ops))
  (set-union worklist update-worklist))

(define (evaluate op vals)
  (match op
    [(AssignLL _ src) (evaluate/src src vals)]
    [(? PhiLL?) 'L]))

(define (evaluate/src src vals)
  (displayln "src")
  (pretty-display src)
  (match src
    [(BinaryLL op _ op1 op2)
     (let ([val1 (hash-ref vals op1 op1)]
           [val2 (hash-ref vals op2 op2)])
       (if (and (const? val1) (const? val2))
           (begin (displayln "eval-m") (displayln ((get-op op) val1 val2)) ((get-op op) val1 val2))
           'T))]
    [(? CallLL?) 'L]
    [(? LoadLL?) 'L]
    [(? CastLL?) 'T]))

(define (get-uses blocks)
  (make-immutable-hash* (get-all uses/stmt blocks)))

(define (uses/stmt stmt)
  (map (lambda (var) (cons var stmt))
       (filter ssa-reg? (stmt-reads stmt))))

                
(define (initial-vals blocks)
  (make-hash (get-all initial-vals/stmt blocks)))

(define (initial-vals/stmt stmt)
  (match stmt
    [(PhiLL id _ _) (list (cons id (evaluate stmt #hash())))]
    [(AssignLL id _) (list (cons id (evaluate stmt #hash())))]
    [_ '()]))    


(define (make-immutable-hash* assocs)
  (make-immutable-hash (map make-hash-entry (group-by car assocs))))

(define (make-hash-entry lst)
  (cons (car (first lst)) (map cdr lst)))

(define (get-op op)
  (hash-ref op-procs op))

(define const? (disjoin integer? boolean?))
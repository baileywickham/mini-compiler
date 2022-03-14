#lang racket

(provide constant-prop)

(require "common.rkt")

(define op-procs
  (hash 'add  +
        'mul  *
        'sub  -
        'sdiv quotient
        'and  (λ (a b) (and a b))
        'or   (λ (a b) (or a b))
        'eq   equal?
        'sle  <=
        'sgt  >
        'sge  >=
        'slt  <
        'xor xor
        'ne   (negate equal?)))

;;
(define+ (constant-prop (LLVM tys decs funs))
  (LLVM tys decs (map prop/fun funs)))

;;
(define+ (prop/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (prop/body body)))

;;
(define (prop/body blocks)
  (define vals (initial-vals blocks))
  (define worklist
    (filter identity
            (hash-map vals (λ (id v) (if (equal? v 'T) #f id)))))
  (define final-values (update-vals worklist vals (get-uses blocks)))
  ((subst-vals* vals) blocks))

;;
(define (subst-vals* vals)

  ;;
  (define (subst-vals/blocks blocks)
    (map subst-vals/block blocks))

  ;;
  (define+ (subst-vals/block (Block id stmts))
    (Block id (map subst-vals/stmt stmts)))

  ;;
  (define (subst-vals/stmt stmt)
    (match stmt
      [(AssignLL target src) (AssignLL target (subst-vals/stmt src))]
      [(BinaryLL op ty op1 op2) (BinaryLL op ty (get-val op1) (get-val op2))]
      [(CallLL ty fn args var-args?)
       (CallLL ty fn (map (λ+ ((cons id ty)) (cons (get-val id) ty)) args) var-args?)]
      [(PhiLL id ty args)
       (PhiLL id ty (map (λ+ ((cons label (cons id ty))) (cons label (cons (get-val id) ty))) args))]
      [(StoreLL ty val ptr) (StoreLL ty (get-val val) (get-val ptr))]
      [(LoadLL ty ptr) (LoadLL ty (get-val ptr))]
      [(CastLL op ty val ty2) (CastLL op ty (get-val val) ty2)]
      [(BrCondLL c iftrue iffalse) (BrCondLL (get-val c) iftrue iffalse)]
      [(ReturnLL ty val) (ReturnLL ty (get-val val))]
      [_ stmt]))

  ;;
  (define (get-val arg)
    (let ([v (hash-ref vals arg arg)])
      (if (const? v) v arg)))

  subst-vals/blocks)

;;
(define (update-vals worklist vals use-graph)
  (match worklist
    ['() vals]
    [(cons r remaining-work)
     (let ([new-work (update-vals/reg r vals use-graph)])
       (update-vals (set-union remaining-work new-work) vals use-graph))]))

;;
(define (update-vals/reg r vals use-graph)
  (define ops (hash-ref use-graph r '()))
  (filter-map (λ (op) (update-vals/op op vals)) ops))

;;
(define (update-vals/op op vals)
  (match (stmt-writes op)
    ['() #f]
    [(list m)
     (define m-val (hash-ref vals m))
     (cond
       [(equal? m-val 'L) #f]
       [else
        (let ([m-eval (evaluate op vals)])
          (hash-set! vals m m-eval)
          (if (equal? m-eval m-val) #f m))])]))

;;
(define (evaluate op vals)
  (match op
    [(AssignLL _ src) (evaluate/src src vals)]
    [(? PhiLL?) 'L]))

;;
(define (evaluate/src src vals)
  (match src
    [(BinaryLL op _ op1 op2)
     (let ([val1 (hash-ref vals op1 op1)]
           [val2 (hash-ref vals op2 op2)])
       (if (and (const? val1) (const? val2))
           ((get-op op) val1 val2)
           'T))]
    [(? CallLL?) 'L]
    [(? LoadLL?) 'L]
    [(CastLL op ty val ty2)
     (let ([new-val (hash-ref vals val val)])
       (if (const? new-val)
           new-val 'T))]
    [(? GetEltLL?) 'T]))

;;
(define (get-uses blocks)
  (make-immutable-hash* (get-all uses/stmt blocks)))

;;
(define (uses/stmt stmt)
  (map (λ (var) (cons var stmt)) (filter ssa-reg? (stmt-reads stmt))))

;;
(define (initial-vals blocks)
  (make-hash (get-all initial-vals/stmt blocks)))

;;
(define (initial-vals/stmt stmt)
  (match stmt
    [(PhiLL id _ _) (list (cons id (evaluate stmt #hash())))]
    [(AssignLL id _) (list (cons id (evaluate stmt #hash())))]
    [_ '()]))

;;
(define (make-immutable-hash* assocs)
  (make-immutable-hash (map make-hash-entry (group-by car assocs))))

;;
(define (make-hash-entry lst)
  (cons (car (first lst)) (map cdr lst)))

;;
(define (get-op op)
  (hash-ref op-procs op))

;;
(define const? (disjoin integer? boolean?))
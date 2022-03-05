#lang racket
(require "ast/llvm.rkt" "util.rkt" "symbol.rkt")
(provide remove-unused)

(define+ (remove-unused (LLVM tys decs funs))
  (LLVM tys decs (map remove-unused/fun funs)))

(define+ (remove-unused/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (remove-unused/body body (map car params))))

(define (remove-unused/body blocks params)
  (define unused (set-subtract (set-subtract (all-writes blocks) (all-reads blocks)) params))
  (if (empty? unused)
      blocks
      (remove-unused/body ((remove-stmts* unused) blocks) params)))

(define (remove-stmts* unused)
  (define (remove-stmts/blocks blocks)
    (map remove-stmts/block blocks))
  
  (define+ (remove-stmts/block (Block id stmts))
    (Block id (filter-map remove-stmts/stmt stmts)))

  (define (remove-stmts/stmt stmt)
    (match stmt
      [(AssignLL (? unused?) (? CallLL? call)) call]
      [(AssignLL (? unused?) _) #f]
      [(PhiLL (? unused?) _ _) #f]
      [_ stmt]))
  (define (unused? v)
    (member v unused))
  remove-stmts/blocks)
  

(define (all-writes blocks)
  (filter ssa-reg? (get-all stmt-writes blocks)))

(define (all-reads blocks)
  (filter ssa-reg? (get-all stmt-reads blocks)))

(define (stmt-writes stmt)
  (match stmt
    [(AssignLL res _) (list res)]
    [(PhiLL id _ _) (list id)]
    [_ '()]))

(define (stmt-reads stmt)
  (match stmt
    [(AssignLL _ src) (stmt-reads src)]
    [(BinaryLL _ _ op1 op2) (list op1 op2)]
    [(BrCondLL cond _ _) (list cond)]
    [(AllocLL _) (error 'optimize "unused values only supported in ssa")]
    [(StoreLL _ val ptr) (list val ptr)]
    [(LoadLL _ ptr) (list ptr)]
    [(ReturnLL _ arg) (list arg)]
    [(GetEltLL _ ptr _) (list ptr)]
    [(CallLL _ _ (list (cons ids _) ...) _) ids]
    [(CastLL _ _ value _) (list value)]
    [(PhiLL _ _ (list (cons label (cons ids _)) ...)) ids]
    [_ '()]))

(define (ssa-reg? v)
  (match v
    [(IdLL _ #f) #t]
    [_ #f]))

(define (get-all proc blocks)
  (append-map
   (λ+ ((Block _ stmts)) (append-map proc stmts))
   blocks))

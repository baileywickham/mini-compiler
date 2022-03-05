#lang racket
(require "util.rkt" "ast/llvm.rkt")
(provide (all-defined-out) (all-from-out "util.rkt" "ast/llvm.rkt"))


(define (get-all proc blocks)
  (append-map
   (λ+ ((Block _ stmts)) (append-map proc stmts))
   blocks))


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

#lang racket

(provide (all-defined-out) (all-from-out "../util.rkt" "../ast/llvm.rkt"))

(require "../util.rkt" "../ast/llvm.rkt")

;;
(define (get-all proc blocks)
  (append-map
   (λ+ ((Block _ stmts)) (append-map proc stmts))
   blocks))

;;
(define (stmt-writes stmt)
  (match stmt
    [(AssignLL res _) (list res)]
    [(PhiLL id _ _) (list id)]
    [_ '()]))

;;
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

;;
(define (ssa-reg? v)
  (match v
    [(IdLL _ #f) #t]
    [_ #f]))

(define (subst-vars s proc)
    (match s
      [(AssignLL result src) (AssignLL (proc result) (subst-vars src proc))]
      [(BinaryLL op ty op1 op2) (BinaryLL op ty (proc op1) (proc op2))]
      [(BrLL label) (BrLL (proc label #t))]
      [(BrCondLL cond iftrue iffalse) (BrCondLL (proc cond) (proc iftrue #t) (proc iffalse #t))]
      [(StoreLL ty val ptr) (StoreLL ty (proc val) (proc ptr))]
      [(LoadLL ty ptr) (LoadLL ty (proc ptr))]
      [(ReturnLL ty arg) (ReturnLL ty (proc arg))]
      [(GetEltLL ty ptr index) (GetEltLL ty (proc ptr) index)]
      [(CallLL ty fn args var-args?) (CallLL ty fn (map (λ+ ((cons id ty)) (cons (proc id) ty)) args) var-args?)]
      [(CastLL op ty value ty2) (CastLL op ty (proc value) ty2)]
      [(PhiLL id ty args)
       (PhiLL (proc id) ty
              (map (λ+ ((cons label (cons id ty)))
                       (cons (proc label) (cons (proc id) ty))) args))]
      [_ s]))

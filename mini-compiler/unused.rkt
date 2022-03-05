#lang racket
(require "ast/llvm.rkt" "util.rkt" "symbol.rkt")
(provide remove-unused)

(define+ (remove-unused (LLVM tys decs funs))
  (LLVM tys decs (map remove-unused/fun funs)))

(define+ (remove-unused/funs (FunLL id params ret-ty body))
  (FunLL id params ret-ty (remove-unused/body body)))

(define (remove-unused/body blocks)
  (define unused (set-subtract (all-writes blocks) (all-reads blocks))))


(define (all-writes blocks)
  (get-all stmt-writes blocks))

(define (all-reads blocks)
  (get-all stmt-reads blocks))

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


    [(StoreLL ty val ptr)
     (format "store ~a ~a, ~a ~a"
             (format-ty ty) (format-arg val) (format-ty (PtrLL ty)) (format-id ptr))]
    [(LoadLL ty ptr)
     (format "load ~a, ~a ~a" (format-ty ty) (format-ty (PtrLL ty)) (format-id ptr))]
    [(ReturnLL _ (? void?)) "ret void"]
    [(ReturnLL ty arg)
     (format "ret ~a ~a" (format-ty ty) (format-arg arg))]
    [(GetEltLL ty ptr index)
     (format "getelementptr ~a, ~a ~a, i1 0, i32 ~a"
             (format-ty ty) (format-ty (PtrLL ty)) (format-arg ptr) index)]
    [(CallLL ty fn args var-args?)
     (format "call ~a~a ~a(~a)"
             (format-ty ty) (if var-args? " (i8*, ... )" "")  (format-id fn) (format-args args))]
    [(CastLL op ty value ty2)
     (format "~a ~a ~a to ~a" op (format-ty ty) (format-arg value) (format-ty ty2))]
    [(PhiLL id ty args)
     (format "~a = phi ~a ~a" (format-id id) (format-ty ty)
             (string-join (map (λ+ ((cons label (cons id _)))
                                   (format "[~a, %~a]" (format-arg id) label)) args) ", "))])

(define (get-all proc blocks)
  (append-map
   (λ+ ((Block _ stmts)) (append-map proc stmts))
   blocks))

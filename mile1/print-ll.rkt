#lang racket

(require "ast.rkt")
(provide print-llvm)

(define comp-ops (set 'sle 'sgt 'sge 'slt 'eq))

(define (print-llvm llvm)
  (string-join (append (map print-struct (LLVM-types llvm))
                       (map print-dec (LLVM-decs llvm))
                       (map print-fun (LLVM-funs llvm)))
               "\n"))

(define (print-struct s)
  (format "~a = type {~a}" (StructLL-id s) (string-join (map print-type (StructLL-types s)) ", ")))

(define (print-type t)
  (match t
    [(? symbol?) (~a t)]
    [(PtrLL to) (format "~a*" (print-type to))]))


(define (print-dec d) "")
(define (print-fun f)
  (string-append (format "define ~a ~a(~a)"
                         (print-type (FunLL-ret-type f))
                         (FunLL-id f)
                         (string-join
                          (map (lambda (p) (format "~a ~a" (print-type (cdr p)) (car p)))
                               (FunLL-params f)) ", "))
                 "\n{\n"
                 (string-join (map print-block (FunLL-body f)) "\n")
                 "\n}\n"))
(define (print-block b)
  (string-append (format "~a: \n\t" (BlockLL-id b))
                 (string-join (map print-stmt (BlockLL-stmts b)) "\n\t")))

(define (print-stmt s)
  (match s
    [(BinaryLL result (? icmp-op? op) ty op1 op2) (format "~a = icmp ~a ~a ~a, ~a" result op (print-type ty) op1 op2)]
    [(BinaryLL result op ty op1 op2) (format "~a = ~a ~a ~a, ~a" result op (print-type ty) op1 op2)]
    [(BrLL label) (format "br label ~a" label)]
    [(BrCondLL cond iftrue iffalse) (format "br i1 ~a, label ~a, label ~a" cond iftrue iffalse)]
    [(AllocLL result ty) (format "~a = alloca ~a" result (print-type ty))]))

(define (icmp-op? op)
  (set-member? comp-ops op)) 

(module+ test
  (require rackunit)
  (display (print-llvm (LLVM (list (StructLL '%hi (list (PtrLL 'i32) 'i32)))
                             '()
                             (list (FunLL '@add '((%x . i32) (%y . i32)) 'i32
                                          (list (BlockLL 'LU1 (list (BinaryLL '%u1 'add 'i32 '%u2 '%u3))))))))))
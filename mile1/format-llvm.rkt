#lang racket

(provide format-llvm)

(require "ast.rkt")

(define comp-ops (set 'sle 'sgt 'sge 'slt 'eq))

;;
(define (format-llvm llvm)
  (string-join (append (map format-struct (LLVM-types llvm))
                       (map format-dec (LLVM-decs llvm))
                       (map format-fun (LLVM-funs llvm))) "\n"))

;;
(define (format-struct s)
  (format "~a = type {~a}" (StructLL-id s) (string-join (map format-type (StructLL-types s)) ", ")))

;;
(define (format-type t)
  (match t
    [(? symbol?) (~a t)]
    [(PtrLL to) (format "~a*" (format-type to))]))

;;
(define (format-dec d) "")

;;
(define (format-fun f)
  (string-append
   (format "define ~a ~a(~a)"
           (format-type (FunLL-ret-type f))
           (FunLL-id f)
           (string-join
            (map (λ (p) (format "~a ~a" (format-type (cdr p)) (car p)))
                 (FunLL-params f)) ", "))
   "\n{\n"
   (string-join (map format-block (FunLL-body f)) "\n")
   "\n}\n"))

;;
(define (format-block b)
  (string-append
   (format "~a:\n" (BlockLL-id b))
   (string-join (map (λ (stmt) (format "\t~a\n" (format-stmt stmt))) (BlockLL-stmts b)))))

;;
(define (format-stmt s)
  (match s
    [(BinaryLL result (? icmp-op? op) ty op1 op2)
     (format "~a = icmp ~a ~a ~a, ~a" result op (format-type ty) op1 op2)]
    [(BinaryLL result op ty op1 op2)
     (format "~a = ~a ~a ~a, ~a" result op (format-type ty) op1 op2)]
    [(BrLL label) (format "br label ~a" label)]
    [(BrCondLL cond iftrue iffalse) (format "br i1 ~a, label ~a, label ~a" cond iftrue iffalse)]
    [(AllocLL result ty) (format "~a = alloca ~a" result (format-type ty))]
    [o (~a o)]))

;;
(define (icmp-op? op)
  (set-member? comp-ops op))


(module+ test
  (require rackunit)

  (display
   (format-llvm
    (LLVM (list (StructLL '%hi (list (PtrLL 'i32) 'i32)))
          '()
          (list (FunLL '@add '((%x . i32) (%y . i32)) 'i32
                       (list
                        (BlockLL 'LU1
                                 (list
                                  (BinaryLL '%u1 'add 'i32 '%u2 '%u3))))))))))
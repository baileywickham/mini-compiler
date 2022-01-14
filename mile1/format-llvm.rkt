#lang racket

(provide format-llvm)

(require "ast.rkt")

;;
(define comp-ops (set 'sle 'sgt 'sge 'slt 'eq))

;;
(define (format-llvm llvm)
  (string-join (append (map format-struct (LLVM-types llvm))
                       (map format-dec (LLVM-decs llvm))
                       (map format-fun (LLVM-funs llvm))) "\n"))

;;
(define (format-struct s)
  (format "~a = type {~a}" (format-id (StructLL-id s)) (string-join (map format-type (StructLL-types s)) ", ")))

;;
(define (format-type t)
  (match t
    [(? IdLL?) (format-id t)]
    [(? string?) t]
    [(? symbol?) (~a t)]
    [(PtrLL to) (format "~a*" (format-type to))]))

(define (format-id id)
  (match id
    [(IdLL id #t) (format "@~a" id)]
    [(IdLL id #f) (format "%~a" id)]
    [o o]))

;;
(define (format-dec d)
  (format "~a = common global ~a ~a, align 4"
          (format-id (GlobalLL-id d))
          (format-type (GlobalLL-ty d))
          (GlobalLL-val d)))

;;
(define (format-fun f)
  (string-append
   (format "define ~a ~a(~a)"
           (format-type (FunLL-ret-type f))
           (format-id (FunLL-id f))
           (string-join
            (map (λ (p) (format "~a ~a" (format-type (cdr p)) (format-id (car p))))
                 (FunLL-params f)) ", "))
   "\n{\n"
   (string-join (map format-block (FunLL-body f)) "\n")
   "\n}\n"))

;;
(define (format-block b)
  (string-append
   (format "~a:\n" (BlockLL-id b))
   (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) (BlockLL-stmts b)) "\n")))

;;
(define (format-stmt s)
  (match s
    [(BinaryLL result (? icmp-op? op) ty op1 op2)
     (format "~a = icmp ~a ~a ~a, ~a" (format-id result) op (format-type ty) (format-arg op1) (format-arg op2))]
    [(BinaryLL result op ty op1 op2)
     (format "~a = ~a ~a ~a, ~a" (format-id result) op (format-type ty) (format-arg op1) (format-arg op2))]
    [(BrLL label) (format "br label ~a" (format-id label))]
    [(BrCondLL cond iftrue iffalse) (format "br i1 ~a, label ~a, label ~a"
                                            (format-id cond) (format-id iftrue) (format-id iffalse))]
    [(AllocLL result ty) (format "~a = alloca ~a" (format-id result) (format-type ty))]
    [(StoreLL ty val ptr) (format "store ~a ~a, ~a ~a"
                                  (format-type ty) (format-id val) (format-type (PtrLL ty)) (format-id ptr))]
    [(LoadLL result ty ptr) (format "~a = load ~a, ~a ~a" (format-id result) (format-type ty) (format-type (PtrLL ptr)) (format-id ptr))]
    [o (~a o)]))

(define (format-arg arg)
  (match arg
    [(? integer?) arg]
    [(? IdLL?) (format-id arg)]))

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
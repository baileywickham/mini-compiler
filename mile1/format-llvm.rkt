#lang racket

(provide format-llvm)

(require "ast.rkt" "util.rkt")

;;
(define comp-ops (set 'sle 'sgt 'sge 'slt 'eq))

;;
(define+ (format-llvm (LLVM types decs funs))
  (string-join (append (map format-struct types)
                       (map format-dec decs)
                       (map format-fun funs)) "\n"))

;;
(define+ (format-struct (StructLL id tys))
  (format "~a = type {~a}"
          (format-id id) (string-join (map format-ty tys) ", ")))

;;
(define+ (format-dec (GlobalLL id ty val))
  (format "~a = common global ~a ~a, align 4"
          (format-id id) (format-ty ty) val))

;;
(define+ (format-fun (FunLL id params ret-ty body))
  (format "define ~a ~a(~a)\n{\n~a\n}\n"
          (format-ty ret-ty)
          (format-id id)
          (format-args params)
          (string-join (map format-block body) "\n")))

;;
(define+ (format-block (BlockLL id stmts))
  (format "~a:\n~a"
          id (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) stmts) "\n")))

;;
(define (format-stmt s)
  (match s
    [(BinaryLL result (? icmp-op? op) ty op1 op2)
     (format "~a = icmp ~a ~a ~a, ~a"
             (format-id result) op (format-ty ty) (format-arg op1) (format-arg op2))]
    [(BinaryLL result op ty op1 op2)
     (format "~a = ~a ~a ~a, ~a"
             (format-id result) op (format-ty ty) (format-arg op1) (format-arg op2))]
    [(BrLL label)
     (format "br label ~a"
             (format-id label))]
    [(BrCondLL cond iftrue iffalse)
     (format "br i1 ~a, label ~a, label ~a"
             (format-id cond) (format-id iftrue) (format-id iffalse))]
    [(AllocLL result ty)
     (format "~a = alloca ~a"
             (format-id result) (format-ty ty))]
    [(StoreLL ty val ptr)
     (format "store ~a ~a, ~a ~a"
             (format-ty ty) (format-id val) (format-ty (PtrLL ty)) (format-id ptr))]
    [(LoadLL result ty ptr)
     (format "~a = load ~a, ~a ~a"
             (format-id result) (format-ty ty) (format-ty (PtrLL ty)) (format-id ptr))]
    [(ReturnLL _ (? void?)) "ret void"]
    [(ReturnLL ty arg)
     (format "ret ~a ~a" (format-ty ty) (format-arg arg))]
    [(GetEltLL result ty ptr index)
     (format "~a = getelementptr ~a, ~a ~a, i1 0, i32 ~a"
             (format-id result) (format-ty ty) (format-ty (PtrLL ty)) (format-arg ptr) index)]
    [(AssignLL result src)
     (format "~a = ~a" (format-id result) (format-stmt src))]
    [(CallLL ty fn args)
     (format "call ~a ~a(~a)" (format-ty ty) (format-id fn) (format-args args))]
    [(BitcastLL ty value ty2)
     (format "bitcast ~a ~a to ~a" (format-ty ty) (format-id value) (format-ty ty2))]
    [o (~a o)]))

(define (format-args args)
  (string-join
           (map (λ+ ((cons id ty)) (format "~a ~a" (format-ty ty) (format-id id))) args) ", "))

;;
(define (format-ty t)
  (match t
    [(? IdLL?) (format-id t)]
    [(? string?) t]
    [(? symbol?) (~a t)]
    [(PtrLL to) (format "~a*" (format-ty to))]
    [o (~a o)]))

;;
(define (format-arg arg)
  (match arg
    [(? integer?) arg]
    [(? IdLL?) (format-id arg)]
    [o (~a o)]))

;;
(define (format-id id)
  (match id
    [(IdLL id #t) (format "@~a" id)]
    [(IdLL id #f) (format "%~a" id)]
    [o o]))

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
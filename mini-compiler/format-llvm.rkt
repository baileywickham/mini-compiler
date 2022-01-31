#lang racket

(provide format-llvm)


(require "ast.rkt" "util.rkt")

;;
(define comp-ops (set 'sle 'sgt 'sge 'slt 'eq 'ne))

(define header "target triple=\"i686\"\n")

(define footer "declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c\"%ld\\0A\\00\\00\", align 1
@.print = private unnamed_addr constant [6 x i8] c\"%ld \\00\\00\", align 1
@.read = private unnamed_addr constant [5 x i8] c\"%ld\\00\\00\", align 1\n")

;;
(define+ (format-llvm (LLVM types decs funs))
  (string-append
   header
   (string-join (list (string-join (map format-struct types) "\n")
                      (string-join (map format-dec decs) "\n")
                      (string-join (map format-fun funs) "\n")) "\n\n")
   footer))

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
          (format-ty ret-ty) (format-id id) (format-args params)
          (string-join (map format-block body) "\n")))

;;
(define+ (format-block (BlockLL id stmts))
  (format "~a:\n~a"
          id (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) stmts) "\n")))

;;
(define (format-stmt s)
  (match s
    [(AssignLL result src)
     (format "~a = ~a" (format-id result) (format-stmt src))]
    [(BinaryLL (? icmp-op? op) ty op1 op2)
     (format "icmp ~a ~a ~a, ~a" op (format-ty ty) (format-arg op1) (format-arg op2))]
    [(BinaryLL op ty op1 op2)
     (format "~a ~a ~a, ~a" op (format-ty ty) (format-arg op1) (format-arg op2))]
    [(BrLL label)
     (format "br label ~a" (format-id label))]
    [(BrCondLL cond iftrue iffalse)
     (format "br i1 ~a, label ~a, label ~a" (format-arg cond) (format-id iftrue) (format-id iffalse))]
    [(AllocLL ty)
     (format "alloca ~a" (format-ty ty))]
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
    ;(struct Phi (id ty [args #:mutable] [complete? #:mutable] var) #:transparent)
    [(Phi id ty args _ _)
     (format "~a = phi ~a ~a" (format-id id) (format-ty ty)
           (string-join (map (λ+ ((cons label (cons id _))) (format "[~a, %~a]" (format-arg id) label)) args) ", "))] 
    [o (~a o)]))

;;
(define (format-args args)
  (string-join
   (map (λ+ ((cons arg ty)) (format "~a ~a" (format-ty ty) (format-arg arg))) args) ", "))

;;
(define (format-ty t)
  (match t
    [(? IdLL?) (format-id t)]
    ['void "void"]
    [(IntLL size) (format "i~a" size)]
    [(PtrLL to) (format "~a*" (format-ty to))]))

;;
(define (format-arg arg)
  (match arg
    ['null "null"]
    [(or (? string?) (? integer?)) arg]
    [(? boolean?) (if arg "true" "false")]
    [(? IdLL?) (format-id arg)]))

;;
(define+ (format-id (IdLL id global?))
  (format "~a~a" (if global? "@" "%") id))

;;
(define (icmp-op? op)
  (set-member? comp-ops op))


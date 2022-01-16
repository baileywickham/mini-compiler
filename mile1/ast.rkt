#lang racket/base

(provide (all-defined-out))

;; --------------------------------------------
;; Mini
;; --------------------------------------------

(struct Mini (types decs funs) #:transparent)
(struct Struct (id fields) #:transparent)
(struct Fun (id params ret-type decs body) #:transparent)

;; Statements
(struct Assign (target source) #:transparent)
(struct If (guard then else) #:transparent)
(struct While (guard body) #:transparent)
(struct Print (exp endl) #:transparent)
(struct Inv (id args) #:transparent)
(struct Return (exp) #:transparent)
(struct Delete (exp) #:transparent)

;; Expressions
(struct Dot (left id) #:transparent)
(struct Prim (op exps) #:transparent)
(struct Null () #:transparent)
(struct New (id) #:transparent)
(struct Read () #:transparent)

;; --------------------------------------------
;; Mini*
;; --------------------------------------------

(struct Goto* (label) #:transparent)
(struct GotoCond* (cond iftrue iffalse) #:transparent)
(struct Block* (id stmts) #:transparent)


;; --------------------------------------------
;; LLVM
;; --------------------------------------------

(struct LLVM (tys decs funs) #:transparent)
(struct StructLL (id types) #:transparent)
(struct GlobalLL (id ty val) #:transparent)
(struct FunLL (id params ret-ty body) #:transparent)
(struct BlockLL (id stmts) #:transparent)

;; Statements
(struct AssignLL (result src) #:transparent)

(struct BinaryLL (op ty op1 op2) #:transparent)
(struct AllocLL (ty) #:transparent)
(struct StoreLL (ty val ptr) #:transparent)
(struct LoadLL (ty ptr) #:transparent)
(struct ReturnLL (ty arg) #:transparent)
(struct GetEltLL (ty ptr index) #:transparent)
(struct CallLL (ty fn args) #:transparent)
(struct BitcastLL (ty value ty2) #:transparent)

(struct BrLL (dest) #:transparent)
(struct BrCondLL (cond iftrue iffalse) #:transparent)
(struct PrintLL (ty arg endl?) #:transparent)
(struct ReadLL (ty arg) #:transparent)

;; Arguments
(struct PtrLL (to) #:transparent)
(struct IdLL (id global?) #:transparent)
(struct IntLL (size) #:transparent) 


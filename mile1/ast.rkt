#lang racket/base

(provide (all-defined-out))

;; --------------------------------------------
;; Mini
;; --------------------------------------------

(struct Mini (types decs funs) #:transparent)
(struct Struct (id fields) #:transparent)
(struct Fun (id params ret-type decs body) #:transparent)

;; Statements
(struct Block (stmts) #:transparent)
(struct Assign (target source) #:transparent)
(struct If (guard then else) #:transparent)
(struct Print (exp endl) #:transparent)
(struct While (guard body) #:transparent)
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
(struct GotoCond* (cond iffalse iftrue) #:transparent)
(struct Fun* (id params ret-type decs cfg start) #:transparent)

;; --------------------------------------------
;; LLVM
;; --------------------------------------------

(struct LLVM (types decs funs) #:transparent)
(struct StructLL (id types) #:transparent)
(struct FunLL (id params ret-type body) #:transparent)
(struct BlockLL (id stmts) #:transparent)
(struct BinaryLL (result op ty op1 op2) #:transparent)
(struct PtrLL (to) #:transparent)

(struct BrLL (dest) #:transparent)
(struct BrCondLL (cond iftrue iffalse) #:transparent)
(struct AllocLL (result ty) #:transparent)


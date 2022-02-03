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
(struct Global (id) #:transparent)

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
(struct CallLL (ty fn args var-args?) #:transparent)
(struct CastLL (op ty val ty2) #:transparent)

(struct BrLL (dest) #:transparent)
(struct BrCondLL (cond iftrue iffalse) #:transparent)
(struct PhiLL (id ty args) #:transparent)

;; Arguments
(struct PtrLL (to) #:transparent)
(struct IdLL (id global?) #:transparent)
(struct IntLL (size) #:transparent)
(struct StringConstLL (id) #:transparent)

;; --------------------------------------------
;; ARM
;; --------------------------------------------

(struct ARM (comms funs) #:transparent)
(struct BlockA (id stmts) #:transparent)
(struct FunA (id blocks) #:transparent)

(struct CommA (id) #:transparent)
(struct OpA (op target r1 op2) #:transparent)
(struct CmpA (r1 op2) #:transparent)
(struct BrA (op label) #:transparent)
(struct MvA (op r1 op2) #:transparent)
(struct LdrA (r1 addr) #:transparent)
(struct StrA (r2 addr) #:transparent)
(struct PushA (regs) #:transparent)
(struct PopA (regs) #:transparent)

(define int-size 64)
(define byte-size 8)

(define bit  (IntLL 1))
(define byte (IntLL byte-size))
(define i32  (IntLL 32))
(define int  (IntLL int-size))





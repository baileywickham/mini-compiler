#lang racket/base

(provide (all-defined-out) (all-from-out "common.rkt"))

(require "common.rkt")

;; --------------------------------------------
;; LLVM
;; --------------------------------------------

(struct LLVM (tys decs funs) #:transparent)
(struct StructLL (id types) #:transparent)
(struct GlobalLL (id ty val) #:transparent)
(struct FunLL (id params ret-ty body) #:transparent)

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


(define int-size 32)
(define byte-size 8)

(define bit  (IntLL 1))
(define byte (IntLL byte-size))
(define i32  (IntLL 32))
(define int  (IntLL int-size))
(define return-var '_retval_)
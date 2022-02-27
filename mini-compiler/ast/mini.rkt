#lang racket/base

(provide (all-defined-out) (all-from-out "common.rkt"))

(require "common.rkt")

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
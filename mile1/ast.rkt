#lang racket/base

(provide (all-defined-out))

(struct Mini (types decs funcs) #:transparent)
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
(struct Return-void () #:transparent)

;; Expressions
(struct Dot (left id) #:transparent)
(struct Binary (op left right) #:transparent)
(struct Null () #:transparent)
(struct New (id) #:transparent)
(struct Unary (op exp) #:transparent)
(struct Read () #:transparent)
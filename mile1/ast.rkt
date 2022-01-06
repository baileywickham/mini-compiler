#lang racket/base

(provide (all-defined-out))

(struct mini (types decs funcs) #:transparent)
(struct type (id fields) #:transparent)
(struct func (id params ret-type decs body) #:transparent)

;; Statements
(struct block (exprs) #:transparent)
(struct assign (target source) #:transparent)
(struct if (guard then else) #:transparent)
(struct print (exp endl) #:transparent)
(struct while (guard body) #:transparent)
(struct inv (id args) #:transparent)
(struct return (exp) #:transparent)
(struct return-void () #:transparent)

;; Expressions
(struct dot (left id) #:transparent)
(struct binop (op left right) #:transparent)
(struct null () #:transparent)
(struct new (id) #:transparent)
(struct unary (op exp) #:transparent)
(struct read () #:transparent)

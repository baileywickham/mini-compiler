#lang racket

(provide parse)

(require "ast.rkt")

(define (parse jsn)
  (mini (map parse-type (hash-ref jsn 'types))
        (map parse-dec (hash-ref jsn 'declarations))
        (map parse-func (hash-ref jsn 'functions))))

(define (parse-type typ)
  (type (string->symbol (hash-ref typ 'id)) (map parse-dec (hash-ref typ 'fields))))

(define (parse-dec dec)
  (cons (string->symbol (hash-ref dec 'id)) (string->symbol (hash-ref dec 'type))))

(define (parse-func fn)
  (func (string->symbol (hash-ref fn 'id))
        (map parse-dec (hash-ref fn 'parameters))
        (string->symbol (hash-ref fn 'return_type))
        (map parse-dec (hash-ref fn 'declarations))
        (map parse-stmt (hash-ref fn 'body))))

(define (parse-stmt stmt)
  (match stmt
    [(hash-table ('stmt "block") ('list l)) (block (map parse-stmt l))]
    [(hash-table ('stmt "assign") ('target target) ('source src))
     (assign (parse-target target) (parse-exp src))]
    [(hash-table ('stmt "if") ('guard guard) ('then then) ('else else))
     (if (parse-exp guard) (parse-stmt then) (parse-stmt else))]
    [(hash-table ('stmt "if") ('guard guard) ('then then))
     (if (parse-exp guard) (parse-stmt then) '())]
    [(hash-table ('stmt "print") ('exp exp) ('endl endl)) (print (parse-exp exp) endl)]
    [(hash-table ('stmt "while") ('guard guard) ('body body))
     (while (parse-exp guard) (parse-stmt body))]
    [(hash-table ('stmt "invocation") ('id id) ('args args))
     (inv (string->symbol id) (map parse-exp args))]
    [(hash-table ('stmt "return") ('exp exp)) (return (parse-exp exp))]
    [(hash-table ('stmt "return")) (return-void)]))

(define (parse-exp exp)
  (match exp
    [(hash-table ('exp "num") ('value v)) (string->number v)]
    [(hash-table ('exp "true")) #t]
    [(hash-table ('exp "false")) #f]
    [(hash-table ('exp "null")) (null)]
    [(hash-table ('exp "id") ('id id)) (string->symbol id)]
    [(hash-table ('exp "invocation") ('id id) ('args args))
     (inv (string->symbol id) (map parse-exp args))]
    [(hash-table ('exp "binary") ('operator op) ('lft lft) ('rht rht))
     (binop (string->symbol op) (parse-exp lft) (parse-exp rht))]
    [(hash-table ('exp "dot") ('left left) ('id id)) (dot (parse-exp left) (string->symbol id))]
    [(hash-table ('exp "new") ('id id)) (new (string->symbol id))]
    [(hash-table ('exp "unary") ('operator op) ('operand exp))
     (unary (string->symbol op) (parse-exp exp))]
    [(hash-table ('exp "read")) (read)]))

(define (parse-target target)
  (match target
    [(hash-table ('left left) ('id id)) (dot (parse-target left) (string->symbol id))]
    [(hash-table ('id id)) (string->symbol id)]))

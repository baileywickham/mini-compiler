#lang racket

(provide parse)

(require "ast.rkt")


(define (parse jsn)
  (Mini (map parse-type (hash-ref jsn 'types))
        (map parse-dec  (hash-ref jsn 'declarations))
        (map parse-fun  (hash-ref jsn 'functions))))

(define (parse-type type)
  (Struct (string->symbol (hash-ref type 'id))
          (map parse-dec (hash-ref type 'fields))))

(define (parse-dec dec)
  (cons (string->symbol (hash-ref dec 'id))
        (string->symbol (hash-ref dec 'type))))

(define (parse-fun fun)
  (Fun (string->symbol (hash-ref fun 'id))
       (map parse-dec  (hash-ref fun 'parameters))
       (string->symbol (hash-ref fun 'return_type))
       (map parse-dec  (hash-ref fun 'declarations))
       (map parse-stmt (hash-ref fun 'body))))

(define (parse-stmt stmt)
  (match stmt
    [(hash-table ('stmt "block") ('list l)) (Block (map parse-stmt l))]
    [(hash-table ('stmt "assign") ('target target) ('source src))
     (Assign (parse-target target) (parse-exp src))]
    [(hash-table ('stmt "if") ('guard guard) ('then then) ('else else))
     (If (parse-exp guard) (parse-stmt then) (parse-stmt else))]
    [(hash-table ('stmt "if") ('guard guard) ('then then))
     (If (parse-exp guard) (parse-stmt then) '())]
    [(hash-table ('stmt "while") ('guard guard) ('body body))
     (While (parse-exp guard) (parse-stmt body))]
    [(hash-table ('stmt "invocation") ('id id) ('args args))
     (Inv (string->symbol id) (map parse-exp args))]
    [(hash-table ('stmt "print") ('exp exp) ('endl endl)) (Print (parse-exp exp) endl)]
    [(hash-table ('stmt "delete") ('exp exp)) (Delete (parse-exp exp))]
    [(hash-table ('stmt "return") ('exp exp)) (Return (parse-exp exp))]
    [(hash-table ('stmt "return")) (Return (void))]))

(define (parse-exp exp)
  (match exp
    [(hash-table ('exp "num") ('value v)) (string->number v)]
    [(hash-table ('exp "true")) #t]
    [(hash-table ('exp "false")) #f]
    [(hash-table ('exp "null")) (Null)]
    [(hash-table ('exp "id") ('id id)) (string->symbol id)]
    [(hash-table ('exp "invocation") ('id id) ('args args))
     (Inv (string->symbol id) (map parse-exp args))]
    [(hash-table ('exp "binary") ('operator op) ('lft lft) ('rht rht))
     (Binary (string->symbol op) (parse-exp lft) (parse-exp rht))]
    [(hash-table ('exp "unary") ('operator op) ('operand exp))
     (Unary (string->symbol op) (parse-exp exp))]
    [(hash-table ('exp "dot") ('left left) ('id id)) (Dot (parse-exp left) (string->symbol id))]
    [(hash-table ('exp "new") ('id id)) (New (string->symbol id))]
    [(hash-table ('exp "read")) (Read)]))

(define (parse-target target)
  (match target
    [(hash-table ('left left) ('id id)) (Dot (parse-target left) (string->symbol id))]
    [(hash-table ('id id)) (string->symbol id)]))

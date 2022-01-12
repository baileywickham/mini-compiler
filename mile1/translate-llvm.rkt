#lang racket

(provide translate-llvm)

(require "ast.rkt")

;;
(define (translate-llvm mini*)
  (LLVM (map translate-struct (Mini-types mini*))
        '()
        (map translate-fun (Mini-funs mini*))))

;;
(define (translate-struct s)
  (StructLL (Struct-id s) (map cdr (Struct-fields s))))

;;
(define (translate-fun f)
  (match f
    [(Fun id params ret-type decs body)
     (let ([blocks (map translate-block body)])
       (FunLL id params ret-type
              (cons (first blocks) (rest blocks))))]))

;;
(define (translate-block b)
  (BlockLL (Block*-id b) (append-map translate-stmt (Block*-stmts b))))

;;
(define (translate-stmt s)
  (list s))

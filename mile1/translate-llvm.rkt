#lang racket
(require "ast.rkt")
(provide translate-llvm)

(define (translate-llvm mini*)
  (LLVM (map translate-struct (Mini-types mini*)) '() '()))

(define (translate-struct s)
  (StructLL (Struct-id s) (map cdr (Struct-fields s))))

(define (translate-fun f)
  (FunLL (Fun-id f) (Fun-params f) (Fun-ret-type f) (map translate-block (Fun-body f))))

(define (translate-block b))
  
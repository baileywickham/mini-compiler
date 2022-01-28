#lang racket

(provide register-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")

(define return-var '_retval_)
(define label-prefix 'LU)

;;
(define+ (register-llvm (Mini types decs funs))
  (reset-labels label-prefix)
  (reset-labels tmp-prefix)
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (map translate-global (translate-decs @ decs))
        (map (λ (f) (translate-fun f structs fun-info)) funs)))

(define (translate-fun fun structs fun-info)
  '())



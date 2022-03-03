#lang racket


(require "ast/llvm.rkt" "ast/arm.rkt" "util.rkt" "symbol.rkt")
(provide cleanup-arm/blocks)

(define (cleanup-arm/blocks blocks)
  (map cleanup-arm/block blocks))

(define+ (cleanup-arm/block (Block id stmts))
  (Block id (filter-map cleanup-arm/stmt stmts)))

(define (cleanup-arm/stmt stmt)
  (match stmt
    [(or (PushA '()) (PopA '())) #f]
    [(MovA #f same same) #f]
    [_ stmt])) 
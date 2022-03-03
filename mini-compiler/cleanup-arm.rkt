#lang racket

(provide cleanup-arm/blocks)

(require "ast/arm.rkt" "util.rkt")

;;
(define (cleanup-arm/blocks blocks)
  (map cleanup-arm/block blocks))

;;
(define+ (cleanup-arm/block (Block id stmts))
  (Block id (filter-map cleanup-arm/stmt stmts)))

;;
(define (cleanup-arm/stmt stmt)
  (match stmt
    [(or (PushA '()) (PopA '())) #f]
    [(MovA #f same same) #f]
    [(OpA (or 'add 'sub) same same (ImmA 0)) #f]
    [(OpA (or 'add 'sub) target source (ImmA 0)) (MovA #f target source)]
    [_ stmt])) 
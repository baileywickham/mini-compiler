#lang racket

(provide define+ λ+)

(define-syntax (define+ syntax-object)
  (syntax-case syntax-object ()
    [(_ (id pat ...) body ...)
     (with-syntax ([(arg ...) (generate-temporaries #'(pat ...))])
       #'(define (id arg ...)
           (match-let ([pat arg] ...)
             body ...)))]))

(define-syntax (λ+ syntax-object)
  (syntax-case syntax-object ()
    [(_ (pat ...) body ...)
     (with-syntax ([(arg ...) (generate-temporaries #'(pat ...))])
       #'(λ (arg ...)
           (match-let ([pat arg] ...)
             body ...)))]))


;(define+ (print-pair (cons a b))
;  (display a)
;  (display b))

;(print-pair '(1 . 2))



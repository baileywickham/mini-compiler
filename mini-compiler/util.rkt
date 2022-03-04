#lang racket

(provide define+ λ+ with-stmts map-indexed map+fold)

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

(define-syntax (with-stmts syntax-object)
  (syntax-case syntax-object (*)
    [(_ ([arg exp] rst ...) body ...)
     #'(let-values ([(arg stmts) exp])
         (append stmts (with-stmts (rst ...) body ...)))]
    [(_ ([^ arg exp] rst ...) body ...)
     #'(let-values ([(arg stmts) exp])
         (with-stmts (rst ...) (append (begin body ...) stmts)))]
    [(_ () body ...)
     #'(begin body ...)]))


(define (map-indexed proc lst)
  (map proc lst (range (length lst))))

(define (map+fold proc init lst)
  (match lst
    ['() (values lst init)]
    [(cons v rst)
     (let*-values ([(new-v new-init) (proc v init)]
                   [(new-lst newer-init) (map+fold proc new-init rst)])
       (values (cons new-v new-lst) newer-init))]))


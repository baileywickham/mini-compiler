#lang racket

(provide control-flow)

(require "ast.rkt")

;;
(define (control-flow mini)
  (struct-copy Mini mini
               [funs (map control-flow-fun (Mini-funs mini))]))

;;
(define (control-flow-fun fun)
  (let ([cfg (make-hash)]
        [start-id (make-label)])
    (hash-set! cfg start-id (stmt-cfg (Fun-body fun) cfg '()))
    (match fun
      [(Fun id params ret-type decs body)
       (Fun* id params ret-type decs cfg start-id)])))

;;
(define (stmt-cfg body cfg next)
  (match body
    [(Block body) (stmt-cfg body cfg next)]
    [(cons (Block body) rest) (stmt-cfg (append body rest) cfg next)]
    [(cons (If guard then '()) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)])
       (hash-set! cfg after-id (stmt-cfg rest cfg next))
       (hash-set! cfg then-id (stmt-cfg then cfg (Goto* after-id)))
       (list (GotoCond* guard then-id after-id)))]
    [(cons (If guard then else) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)]
           [else-id (make-label)])
       (hash-set! cfg after-id (stmt-cfg rest cfg next))
       (hash-set! cfg then-id (stmt-cfg then cfg (Goto* after-id)))
       (hash-set! cfg else-id (stmt-cfg else cfg (Goto* after-id)))
       (list (GotoCond* guard then-id else-id)))]
    [(cons (While guard body) rest)
     (let ([after-id (make-label)]
           [while-id (make-label)])
       (hash-set! cfg after-id (stmt-cfg rest cfg next))
       (hash-set! cfg while-id (stmt-cfg body cfg (GotoCond* guard while-id after-id)))
       (list (GotoCond* guard while-id after-id)))]
    [(cons stmt rest) (cons stmt (stmt-cfg rest cfg next))]
    ['() (list next)]))
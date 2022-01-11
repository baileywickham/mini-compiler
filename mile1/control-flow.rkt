#lang racket

(provide control-flow)

(require "ast.rkt")

;;
(define (control-flow mini)
  (struct-copy Mini mini
               [funs (map control-flow-fun (Mini-funs mini))]))

;;
(define (control-flow-fun fun)
  (let* ([cfg (box '())]
         [add-block! (lambda (b) (set-box! cfg (cons b (unbox cfg))))]
         [start-id (make-label)])
    (add-block! (Block* start-id (stmt-cfg (Fun-body fun) add-block! '())))
    (match fun
      [(Fun id params ret-type decs body)
       (Fun id params ret-type decs (unbox cfg))])))

;;
(define (stmt-cfg body add-block! next)
  (match body
    [(Block body) (stmt-cfg body add-block! next)]
    [(cons (Block body) rest) (stmt-cfg (append body rest) add-block! next)]
    [(cons (If guard then '()) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)])
       (add-block! (Block* after-id (stmt-cfg rest add-block! next)))
       (add-block! (Block* then-id (stmt-cfg then add-block! (Goto* after-id))))
       (list (GotoCond* guard then-id after-id)))]
    [(cons (If guard then else) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)]
           [else-id (make-label)])
       (add-block! (Block* after-id (stmt-cfg rest add-block! next)))
       (add-block! (Block* else-id (stmt-cfg else add-block! (Goto* after-id))))
       (add-block! (Block* then-id (stmt-cfg then add-block! (Goto* after-id))))
       (list (GotoCond* guard then-id else-id)))]
    [(cons (While guard body) rest)
     (let ([after-id (make-label)]
           [while-id (make-label)])
       (add-block! (Block* after-id (stmt-cfg rest add-block! next)))
       (add-block! (Block* while-id (stmt-cfg body add-block! (GotoCond* guard while-id after-id))))
       (list (GotoCond* guard while-id after-id)))]
    [(cons stmt rest) (cons stmt (stmt-cfg rest add-block! next))]
    ['() (list next)]))

(define (make-label)
  (gensym 'u))

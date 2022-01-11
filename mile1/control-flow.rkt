#lang racket

(provide control-flow)

(require "ast.rkt")

;;
(define label-counter (box 0))

;;
(define (control-flow mini)
  (reset-labels)
  (struct-copy Mini mini
               [funs (map control-flow-fun (Mini-funs mini))]))

;;
(define (control-flow-fun fun)
  (let* ([cfg (box '())]
         [add-block! (λ (l b) (set-box! cfg (cons (Block* l b) (unbox cfg))))]
         [start-id (make-label)])
    (add-block! start-id (stmt-cfg (Fun-body fun) add-block! '()))
    (struct-copy Fun fun [body (unbox cfg)])))

;;
(define (stmt-cfg body add-block! next)
  (match body
    [(Block body) (stmt-cfg body add-block! next)]
    [(cons (Block body) rest) (stmt-cfg (append body rest) add-block! next)]
    [(cons (If guard then '()) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id)))
       (list (GotoCond* guard then-id after-id)))]
    [(cons (If guard then else) rest)
     (let ([after-id (make-label)]
           [then-id (make-label)]
           [else-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next))
       (add-block! else-id (stmt-cfg else add-block! (Goto* after-id)))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id)))
       (list (GotoCond* guard then-id else-id)))]
    [(cons (While guard body) rest)
     (let ([after-id (make-label)]
           [while-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next))
       (add-block! while-id (stmt-cfg body add-block! (GotoCond* guard while-id after-id)))
       (list (GotoCond* guard while-id after-id)))]
    [(cons stmt rest) (cons stmt (stmt-cfg rest add-block! next))]
    ['() (list next)]))

;;
(define (reset-labels)
  (set-box! label-counter 0))

;;
(define (make-label)
 (let ([id (unbox label-counter)])
   (set-box! label-counter (add1 id))
   (string->symbol (format "LU~a" id))))

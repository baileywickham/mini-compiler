#lang racket

(provide control-flow)

(require "ast.rkt")

(define return-var '_retval_)

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
         [end-id (make-label)]
         [start-id (make-label)]
         [void-ret? (equal? (Fun-ret-type fun) 'void)]
         [decs (Fun-decs fun)])
    (add-block! end-id (list (Return (if void-ret? (void) return-var))))
    (add-block! start-id (stmt-cfg (Fun-body fun) add-block! (Goto* end-id) end-id))
    (struct-copy Fun fun
                 [body (unbox cfg)]
                 [decs (if void-ret? decs (cons (cons return-var (Fun-ret-type fun)) decs))])))

;;
(define (stmt-cfg body add-block! next ret-id)
  (match body
    [(cons (? list? body) rest) (stmt-cfg (append body rest) add-block! next ret-id)]
    [(cons (If guard then '()) rest)
     (let ([after-id (make-label)] [then-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next ret-id))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id) ret-id))
       (list (GotoCond* guard then-id after-id)))]
    [(cons (If guard then else) rest)
     (let ([after-id (make-label)] [then-id (make-label)] [else-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next ret-id))
       (add-block! else-id (stmt-cfg else add-block! (Goto* after-id) ret-id))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id) ret-id))
       (list (GotoCond* guard then-id else-id)))]
    [(cons (While guard body) rest)
     (let ([after-id (make-label)] [while-id (make-label)])
       (add-block! after-id (stmt-cfg rest add-block! next ret-id))
       (add-block! while-id (stmt-cfg body add-block! (GotoCond* guard while-id after-id) ret-id))
       (list (GotoCond* guard while-id after-id)))]
    [(cons (Return (? void?)) _) (list (Goto* ret-id))]
    [(cons (Return exp) _) (list (Assign return-var exp) (Goto* ret-id))]
    [(cons stmt rest) (cons stmt (stmt-cfg rest add-block! next ret-id))]
    ['() (list next)]))

;;
(define (reset-labels)
  (set-box! label-counter 0))

;;
(define (make-label)
  (let ([id (unbox label-counter)])
    (set-box! label-counter (add1 id))
    (string->symbol (format "LU~a" id))))


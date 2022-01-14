#lang racket

(provide control-flow)

(require "ast.rkt" "util.rkt")

(define return-var '_retval_)

;;
(define label-counter (box 0))

;;
(define+ (control-flow (Mini types decs funs))
  (reset-labels)
  (Mini types decs (map control-flow-fun funs)))

;;
(define+ (control-flow-fun (Fun id params ret-type decs body))
  (let* ([cfg (box '())]
         [add-block! (λ (l b) (set-box! cfg (cons (Block* l b) (unbox cfg))))])
    (with-labels (end-id start-id)
      (add-block! end-id (list (Return (if (equal? ret-type 'void) (void) return-var))))
      (add-block! start-id (stmt-cfg body add-block! (Goto* end-id) end-id)))
    (Fun id params ret-type
         (if (equal? ret-type 'void) decs (cons (cons return-var ret-type) decs))
         (unbox cfg))))

;;
(define (stmt-cfg body add-block! next ret-id)
  (match body
    [(cons (? list? body) rest) (stmt-cfg (append body rest) add-block! next ret-id)]
    [(cons (If guard then '()) rest)
     (with-labels (then-id after-id)
       (add-block! after-id (stmt-cfg rest add-block! next ret-id))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id) ret-id))
       (list (GotoCond* guard then-id after-id)))]
    [(cons (If guard then else) rest)
     (with-labels (then-id else-id after-id)
       (add-block! after-id (stmt-cfg rest add-block! next ret-id))
       (add-block! else-id (stmt-cfg else add-block! (Goto* after-id) ret-id))
       (add-block! then-id (stmt-cfg then add-block! (Goto* after-id) ret-id))
       (list (GotoCond* guard then-id else-id)))]
    [(cons (While guard body) rest)
     (with-labels (while-id after-id)
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

;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label)] ...) body ...)]))

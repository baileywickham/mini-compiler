#lang racket

(provide control-flow)

(require "ast/mini.rkt" "util.rkt" "symbol.rkt")

(define return-var '_retval_)
(define label-prefix 'LU)

;;
(define+ (control-flow (Mini types decs funs))
  (reset-labels label-prefix)
  (Mini types decs (map control-flow-fun funs)))

;;
(define+ (control-flow-fun (Fun id params ret-type decs body))
  (let-values ([(add-block! get-cfg) (make-cfg)])
    (with-labels (end-id start-id)
      (add-block! end-id (list (Return (if (equal? ret-type 'void) (void) return-var))))
      (add-block! start-id ((stmt-cfg add-block! end-id) body (Goto* end-id))))
    (Fun id params ret-type
         (if (equal? ret-type 'void) decs (cons (cons return-var ret-type) decs)) (get-cfg))))

;;
(define (make-cfg)
  (let* ([cfg (box '())])
    (values (λ (label block) (set-box! cfg (cons (Block label block) (unbox cfg)))) ;; add-block!
            (thunk (unbox cfg))))) ;; get-cfg

;;
(define (stmt-cfg add-block! ret-id)
  (define (stmt-cfg* body next)
    (match body
      [(cons (? list? body) rest) (stmt-cfg* (append body rest) next)]
      [(cons (If guard then '()) rest)
       (with-labels (then-id after-id)
         (add-block! after-id (stmt-cfg* rest next))
         (add-block! then-id  (stmt-cfg* then (Goto* after-id)))
         (list (GotoCond* guard then-id after-id)))]
      [(cons (If guard then else) rest)
       (with-labels (then-id else-id after-id)
         (add-block! after-id (stmt-cfg* rest next))
         (add-block! else-id  (stmt-cfg* else (Goto* after-id)))
         (add-block! then-id  (stmt-cfg* then (Goto* after-id)))
         (list (GotoCond* guard then-id else-id)))]
      [(cons (While guard body) rest)
       (with-labels (while-id after-id)
         (add-block! after-id (stmt-cfg* rest next))
         (add-block! while-id (stmt-cfg* body (GotoCond* guard while-id after-id)))
         (list (GotoCond* guard while-id after-id)))]
      [(cons (Return (? void?)) _) (list (Goto* ret-id))]
      [(cons (Return exp) _) (list (Assign return-var exp) (Goto* ret-id))]
      [(cons stmt rest) (cons stmt (stmt-cfg* rest next))]
      ['() (list next)]))
  stmt-cfg*)


;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label label-prefix)] ...) body ...)]))
#lang racket

(provide register-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")

(define return-var '_retval_)
(define label-prefix 'LU)
(struct Block (id [preds #:mutable] [phis #:mutable] [stmts #:mutable] [sealed? #:mutable]) #:transparent)

;;
(define+ (register-llvm (Mini types decs funs))
  (reset-labels)
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (map translate-global (translate-decs @ decs))
        (map (λ (f) (translate-fun f structs fun-info)) funs)))

(define+ (translate-fun (Fun id params ret-type decs body) structs fun-info)
  (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
         (translate-cfg params body structs fun-info)))

(define (translate-cfg params body structs fun-info)
  (define cfg (box '()))
  (define cfg-hash (make-hash))
  (define (add-block! id sealed?)
    (define block (Block id '() '() '() sealed?))
    (hash-set! cfg-hash id block)
    (set-box! cfg (cons block (unbox cfg)))
    id)
  (define (add-stmt! block-id stmt)
    (define block (hash-ref cfg-hash block-id))
    (set-Block-stmts! block (cons stmt (Block-stmts block))))
  (with-labels (end-id start-id)
    (define start-block (add-block! start-id #t))
    (translate-body body start-block add-block! add-stmt! (Goto* end-id) end-id)
    (define end-block (add-block! end-id #t))
    0)
  (unpack-cfg (unbox cfg)))

(define (unpack-cfg cfg)
  (reverse (map (λ+ ((Block id _ phis stmts _))
                    (BlockLL id (append phis (reverse stmts)))) cfg)))
  
  


  #;(define+ (control-flow-fun (Fun id params ret-type decs body))
  (let-values ([(add-block! get-cfg) (make-cfg)])
    (with-labels (end-id start-id)
      (add-block! end-id (list (Return (if (equal? ret-type 'void) (void) return-var))))
      (add-block! start-id ((stmt-cfg add-block! end-id) body (Goto* end-id))))
    (Fun id params ret-type
         (if (equal? ret-type 'void) decs (cons (cons return-var ret-type) decs)) (get-cfg))))

(define (translate-body body current-block add-block! add-stmt! next ret-id)
  (match body
    [(cons (? list? stmts) rest)
     (translate-body (append stmts rest) current-block add-block! add-stmt! next ret-id)]
    [(cons (If guard then else) after)
     (with-labels (then-id else-id after-id)
         (translate-body then (add-block! then-id #t) add-block! add-stmt! (Goto* after-id) ret-id)
         (translate-body else (add-block! else-id #t) add-block! add-stmt! (Goto* after-id) ret-id)
         (translate-body after (add-block! after-id #t) add-block! add-stmt! next ret-id)
         (add-stmt! current-block (GotoCond* guard then-id else-id)))]
    [(cons (While guard while-body) after)
     (with-labels (while-id after-id)
         (translate-body while-body (add-block! while-id #f) add-block! add-stmt! (GotoCond* guard while-id after-id) ret-id)
         (translate-body after (add-block! after-id #t) add-block! add-stmt! next ret-id)
         (add-stmt! current-block (GotoCond* guard while-id after-id)))]
    [(cons (Return (? void?)) _) (add-stmt! current-block (Goto* ret-id))]
    [(cons (Return exp) _) (add-stmt! current-block (Assign return-var exp))
                           (add-stmt! current-block (Goto* ret-id))]
    [(cons stmt rest) (translate-stmt stmt current-block add-stmt!)
                      (translate-body rest current-block add-block! add-stmt! next ret-id)]
    ['() (add-stmt! current-block next)]))

(define (translate-stmt stmt current-block add-stmt!)
  (add-stmt! current-block stmt))



;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label label-prefix)] ...) body ...)]))
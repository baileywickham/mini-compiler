#lang racket
(require json)

(struct mini (types decs funcs) #:transparent)
(struct type (id fields) #:transparent)
(struct func (id params ret-type decs body) #:transparent)

;; Statements
(struct block (exprs) #:transparent)
(struct assign (src target) #:transparent)
(struct if (guard then else) #:transparent)
(struct print (exp endl) #:transparent)
(struct while (guard body) #:transparent)
(struct inv (id args) #:transparent)
(struct return (exp) #:transparent)

;; Expressions
(struct dot (left id) #:transparent)
(struct binop (op left right) #:transparent)
(struct null () #:transparent)
(struct new (id) #:transparent)



(define (main)
  (with-input-from-file "1.json"
    (lambda () (parse (read-json)))))

(define (parse jsn)
  (mini (map parse-type (hash-ref jsn 'types))
        (map parse-dec (hash-ref jsn 'declarations))
        (map parse-func (hash-ref jsn 'functions))))

(define (parse-type typ)
  (type (hash-ref typ 'id) (map parse-dec (hash-ref typ 'fields))))

(define (parse-dec dec)
  (cons (hash-ref dec 'id) (hash-ref dec 'type)))

(define (parse-func fn)
  (func (hash-ref fn 'id)
        (map parse-dec (hash-ref fn 'parameters))
        (hash-ref fn 'return_type)
        (map parse-dec (hash-ref fn 'declarations))
        (map parse-stmt (hash-ref fn 'body))))

(define (parse-stmt stmt)
  (match stmt
    [(hash-table ('stmt "block") ('list l)) (block (map parse-stmt l))]
    [(hash-table ('stmt "assign") ('source src) ('target target)) (assign (parse-exp src) (parse-exp target))]
    [(hash-table ('stmt "if") ('guard guard) ('then then) ('else else))
     (if (parse-exp guard) (parse-stmt then) (parse-stmt else))]
    [(hash-table ('stmt "if") ('guard guard) ('then then)) (if (parse-exp guard) (parse-stmt then) '())]
    [(hash-table ('stmt "print") ('exp exp) ('endl endl)) (print (parse-exp exp) endl)]
    [(hash-table ('stmt "while") ('guard guard) ('body body)) (while (parse-exp guard) (parse-stmt body))]
    [(hash-table ('stmt "invocation") ('id id) ('args args)) (inv id (map parse-exp args))]
    [(hash-table ('stmt "return") ('exp exp)) (return (parse-exp exp))]))

(define (parse-exp exp)
  (match exp
    [(hash-table ('exp "num") ('value v)) (string->number v)]
    [(hash-table ('exp "true")) #t]
    [(hash-table ('exp "false")) #f]
    [(hash-table ('exp "null")) (null)]
    [(hash-table ('exp "id") ('id id)) id]
    [(hash-table ('exp "invocation") ('id id) ('args args)) (inv id (map parse-exp args))]
    [(hash-table ('exp "binary") ('operator op) ('lft lft) ('rht rht)) (binop op (parse-exp lft) (parse-exp rht))]
    [(hash-table ('exp "dot") ('left left) ('id id)) (dot (parse-exp left) id)]
    [(hash-table ('exp "new") ('id id)) (new id)]
    [o o]))
    


(main)
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
    [(hash-table ('stmt "assign") ('source src) ('target target)) (assign src target)]
    [(hash-table ('stmt "if") ('guard guard) ('then then) ('else else))
     (if guard (parse-stmt then) (parse-stmt else))]
    [(hash-table ('stmt "if") ('guard guard) ('then then)) (if guard (parse-stmt then) '())]
    [(hash-table ('stmt "print") ('exp exp) ('endl endl)) (print exp endl)]
    [(hash-table ('stmt "while") ('guard guard) ('body body)) (while guard (parse-stmt body))]
    [(hash-table ('stmt "invocation") ('id id) ('args args)) (inv id args)]
    [(hash-table ('stmt "return") ('exp exp)) (return exp)]))


(main)
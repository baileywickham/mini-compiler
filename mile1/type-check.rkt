#lang racket

(provide type-check)

(require racket/hash)
(require "ast.rkt")

(struct Fun-type (params ret) #:transparent)

(define base-types (set 'int 'bool))
(define main-type (Fun-type '() 'int))

(define binary-types #hash((+ . (int . int))
                           (- . (int . int))
                           (* . (int . int))
                           (/ . (int . int))
                           (&& . (bool . bool))
                           (\|\| . (bool . bool))
                           (<= . (int . bool))
                           (== . (int . bool))
                           (>= . (int . bool))
                           (< . (int . bool))
                           (> . (int . bool))))

(define unary-types #hash((- . int)
                          (! . bool)))

;;
(define (type-check mini)
  (let* ([types (set-union base-types (apply set (map Struct-id (Mini-types mini))))]
         ;; Hash table of the function ids and their parameter and return types
         [fun-sigs (gather-fun-types (Mini-funs mini) types)]
         ;; Hash table of hash tables representing the structs and the member variables
         [structs (make-hash (map (λ (s) (cons (Struct-id s) (build-tenv (Struct-fields s) types)))
                                  (Mini-types mini)))]
         ;; Hash table of global declarations and their types
         [global-tenv (build-tenv (Mini-decs mini) types)])
    (for ([fun (Mini-funs mini)])
      (let ([tenv (hash-union (build-tenv (append (Fun-params fun) (Fun-decs fun)) types) global-tenv
                              #:combine (λ (loc glob) loc))]
            [ret-type (Fun-ret-type fun)])
        (for ([stmt (Fun-body fun)])
          (type-check-stmt stmt structs fun-sigs tenv ret-type)))
      (unless (or (equal? (Fun-ret-type fun) 'void)
                  (stmts-always-return? (Fun-body fun)))
        (type-error "function ~e does not return in all cases" (Fun-id fun))))
    (let ([main (hash-ref fun-sigs 'main (λ () (type-error "could not find function main")))])
      (unless (equal? main main-type)
        (type-error "main expects no arguments and returns an int")))))

;;
(define (type-check-stmt stmt structs fun-sigs tenv ret-type)
  (match stmt
    [(Block stmts)
     (for ([stmt stmts]) (type-check-stmt stmt structs fun-sigs tenv ret-type))]
    [(Assign target src)
     (let ([target (type-check-exp target structs fun-sigs tenv)]
           [src (type-check-exp src structs fun-sigs tenv)])
       (unless (type-equal? target src structs)
         (type-error "mismatched assignment types: ~e ~e" target src)))]
    [(If guard then else)
     (let ([guard (type-check-exp guard structs fun-sigs tenv)])
       (unless (equal? 'bool guard) (type-error "if guard expected bool, got ~e" guard))
       (type-check-stmt then structs fun-sigs tenv ret-type)
       (unless (null? else) (type-check-stmt else structs fun-sigs tenv ret-type)))]
    [(While guard body)
     (let ([guard (type-check-exp guard structs fun-sigs tenv)])
       (unless (equal? 'bool guard) (type-error "while guard expected bool, got ~e" guard))
       (type-check-stmt body structs fun-sigs tenv ret-type))]
    [(Print exp _)
     (let ([exp (type-check-exp exp structs fun-sigs tenv)])
       (unless (equal? 'int exp) (type-error "print expected int, got ~e" exp)))]
    [(Return exp)
     (let ([exp-type (type-check-exp exp structs fun-sigs tenv)])
       (unless (equal? exp-type ret-type)
         (type-error "expected return type ~e got ~e" ret-type exp-type)))]
    [(Return-void)
     (unless (equal? ret-type 'void) (type-error "expected return type ~e got void" ret-type))]
    [(Inv id args)
     (let* ([fun-type (hash-ref fun-sigs id (λ () (type-error "undefined function ~e" id)))]
            [arg-types (map (λ (a) (type-check-exp a structs fun-sigs tenv)) args)]
            [param-types (Fun-type-params fun-type)])
       (if (and (equal? (length arg-types) (length param-types))
                (andmap (λ (actual expected) (type-equal? expected actual structs))
                        arg-types param-types))
           (Fun-type-ret fun-type)
           (type-error "cound not call ~e with arguments ~e" id arg-types)))]
    [(Delete exp) (let ([exp-type (type-check-exp exp structs fun-sigs tenv)])
       (unless (hash-has-key? structs exp-type)
         (type-error "could not delete non struct: ~e" exp-type)))]
 

    ))

;;
(define (type-check-exp exp structs fun-sigs tenv)
  (match exp
    [(? integer?) 'int]
    [(? boolean?) 'bool]
    [(? symbol? s) (hash-ref tenv s (λ () (type-error "unbound identifier: ~e" s)))]
    [(New id) (if (hash-has-key? structs id) id (type-error "undefined struct type: ~e" id))]
    [(Read) 'int]
    [(Null) 'null]
    [(Dot left id)
     (hash-ref (hash-ref structs (type-check-exp left structs fun-sigs tenv)
                         (λ () (type-error "~e is not of struct type" left)))
               id (λ () (type-error "struct does not have member ~e" id)))]
    [(Binary op left right)
     (let ([type-sig (hash-ref binary-types op)]
           [left (type-check-exp left structs fun-sigs tenv)]
           [right (type-check-exp right structs fun-sigs tenv)])
       (if (and (equal? left right) (equal? (car type-sig) left))
           (cdr type-sig)
           (type-error "~e: invaid types ~e ~e" op left right)))]
    [(Unary op exp)
     (let ([type-sig (hash-ref unary-types op)]
           [exp-type (type-check-exp exp structs fun-sigs tenv)])
       (if (equal? type-sig exp-type)
           exp-type
           (type-error "could not invoke ~e on ~e" op exp-type)))]
    [(Inv id args)
     (let* ([fun-type (hash-ref fun-sigs id (λ () (type-error "undefined function ~e" id)))]
            [arg-types (map (λ (a) (type-check-exp a structs fun-sigs tenv)) args)]
            [param-types (Fun-type-params fun-type)])
       (if (and (equal? (length arg-types) (length param-types))
                (andmap (λ (actual expected) (type-equal? expected actual structs))
                        arg-types param-types))
           (Fun-type-ret fun-type)
           (type-error "cound not call ~e with arguments ~e" id arg-types)))]))

;;
(define (extract-Fun-type fun types)
  (let [(param-types (map cdr (Fun-params fun))) (ret-type (Fun-ret-type fun))]
    (for ([ty param-types])
      (unless (set-member? types ty)
        (type-error "unrecognized parameter type: ~e" ty)))
    (unless (or (equal? 'void ret-type) (set-member? types ret-type))
      (type-error "unrecognized return type: ~e" ret-type))
    (Fun-type param-types ret-type)))

;;
(define (type-equal? expected actual structs)
  (or (and (equal? actual 'null) (hash-has-key? structs expected)) (equal? expected actual)))

;;
(define (gather-fun-types funs types)
  (make-hash-unique (map (λ (fun) (cons (Fun-id fun) (extract-Fun-type fun types))) funs)
                    (λ (id) (type-error "duplicate function id ~e" id))))

;;
(define (build-tenv decs types)
  (make-hash-unique (map (λ (dec) (unless (set-member? types (cdr dec))
                                    (type-error "invalid type ~e" (cdr dec))) dec) decs)
                    (λ (id) (type-error "redefinition of variable ~e" id))))

;;
(define (make-hash-unique assocs err)
  (let ([duplicate (check-duplicates (map car assocs))])
    (if duplicate (err duplicate) (make-immutable-hash assocs))))

;;
(define (type-error message . values)
  (apply error 'type-error message values))

;;
(define (stmts-always-return? stmts)
  (ormap stmt-always-returns? stmts))

;;
(define (stmt-always-returns? stmt)
  (match stmt
    [(? Return?) #t]
    [(Block stmts) (stmts-always-return? stmts)]
    [(If _ then else) (and (stmt-always-returns? then) (stmt-always-returns? else))]
    [_ #f]))



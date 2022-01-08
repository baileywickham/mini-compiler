#lang racket

(provide type-check)

(require racket/hash)
(require "ast.rkt")

(struct Fun-type (params ret) #:transparent)
(struct Type-info (type-names structs fun-types) #:transparent)

(define base-types (set 'int 'bool))

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
                              #:combine (λ (loc glob) loc))])
        (for ([stmt (Fun-body fun)])
          (type-check-stmt stmt structs fun-sigs tenv))))))

;;
(define (type-check-stmt stmt structs fun-sigs tenv)
  (match stmt
    [(Block stmts) (for ([stmt stmts]) (type-check-stmt stmt structs fun-sigs tenv))]
    [(Assign target src) (let ([target (type-check-exp target structs fun-sigs tenv)]
                               [src (type-check-exp src structs fun-sigs tenv)])
                           (unless (equal? src target)
                             (type-error "mismatched assignment types: ~e ~e" target src)))]
    [(If guard then else) (let ([guard (type-check-exp guard structs fun-sigs tenv)])
                            (unless (equal? 'bool guard)
                              (type-error "if guard expected bool, got ~e" guard))
                            (type-check-stmt then structs fun-sigs tenv)
                            (type-check-stmt else structs fun-sigs tenv))]
    [(While guard body) (let ([guard (type-check-exp guard structs fun-sigs tenv)])
                          (unless (equal? 'bool guard)
                            (type-error "while guard expected bool, got ~e" guard))
                          (type-check-stmt body structs fun-sigs tenv))]
    [(Print exp _) (let ([exp (type-check-exp exp structs fun-sigs tenv)])
                     (unless (equal? 'int exp)
                       (type-error "print expected int, got ~e" exp)))]
    [o o]))

;;
(define (type-check-exp exp structs fun-sigs tenv)
  (match exp
    [(Dot left id) (hash-ref
                    (hash-ref structs (type-check-exp left structs fun-sigs tenv)
                              (λ () (type-error "~e is not of struct type" left)))
                    id (λ () (type-error "struct does not have member ~e" id)))]
    [(Binary op left right) (let ([type-sig (hash-ref binary-types op)]
                                  [left (type-check-exp left structs fun-sigs tenv)]
                                  [right (type-check-exp right structs fun-sigs tenv)])
                              (if (and (equal? left right) (equal? (car type-sig) left))
                                  (cdr type-sig)
                                  (type-error "~e: invaid types ~e ~e" op left right)))]
    
    ))

;;
(define (extract-Fun-type fun types)
  (let [(param-types (map cdr (Fun-params fun))) (ret-type (Fun-ret-type fun))]
    (for ([ty param-types])
      (unless (set-member? types ty)
        (type-error "unrecognized parameter type: ~e" ty)))
    (unless (or (equal? 'void ret-type) (set-member? types ret-type))
      (type-error "unrecognized return type: ~e" ret-type))
    (Fun-type param-types ret-type)))

;(define (check-inv inv types tenv))

;;
(define (gather-fun-types funs types)
  (make-hash-unique (map (λ (fun) (cons (Fun-id fun) (extract-Fun-type fun types))) funs)))

;;
(define (build-tenv decs types)
  (make-hash-unique (map (λ (dec) (unless (set-member? types (cdr dec))
                                    (type-error "invalid type ~e" (cdr dec))) dec) decs)))

;;
(define (make-hash-unique assocs)
  (let ([h (make-immutable-hash assocs)])
    (if (= (hash-count h) (length assocs)) h
        (type-error "duplicate in ~e" assocs))))

;;
(define (type-error message . values)
  (apply error 'type-error message values))



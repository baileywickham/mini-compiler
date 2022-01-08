#lang racket

(require "ast.rkt"
         racket/hash)
(provide type-check)

(struct Fun-type (params ret) #:transparent)
(struct Type-info (type-names structs fun-types) #:transparent)

(define base-types #hash((int . #hash())
                         (bool . #hash())))

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


(define (type-check mini)
  (define type-set (list->set (append (hash-keys base-types) (map Struct-id (Mini-types mini)))))
  (define fun-sigs (gather-fun-types type-set (Mini-funs mini) #hash()))
  (define types (hash-union base-types
                            (make-hash (map (λ (s)
                                              (cons (Struct-id s)
                                                    (build-tenv (Struct-fields s) #hash() type-set)))
                                            (Mini-types mini)))))
  (define global-tenv (build-tenv (Mini-decs mini) #hash() type-set))
  (map (λ (fun) (type-check-fun fun types global-tenv)) (Mini-funcs mini)))

(define (type-check-fun fun types global-tenv)
  (hash-union
   (build-tenv (append (Fun-params fun) (Fun-decs fun)) #hash() (list->set (hash-keys types)))
   global-tenv
   #:combine (λ (a b) a)))

(define (type-check-stmt stmt types tenv)
  (match stmt
    [(Block stmts) (map (λ (s) (type-check-stmt s types tenv)) stmts)]
    [(Assign target src) (let ([target (type-check-exp target types tenv)]
                               [src (type-check-exp src types tenv)])
                           (unless (equal? src target)
                             (error "mismatched assignment types: ~e ~e" target src)))]
    [(If guard then else) (let ([guard (type-check-exp guard types tenv)])
                            (unless (equal? 'bool guard)
                              (error "if guard expected bool, got ~e" guard))
                            (type-check-stmt then types tenv)
                            (type-check-stmt else types tenv))]
    [(While guard body) (let ([guard (type-check-exp guard types tenv)])
                          (unless (equal? 'bool guard)
                            (error "while guard expected bool, got ~e" guard))
                          (type-check-stmt body types tenv))]
    [(Print exp _) (let ([exp (type-check-exp exp types tenv)])
                     (unless (equal? 'int exp)
                       (error 'type-check "print expected int, got ~e" exp)))]
    [o o]))

(define (type-check-exp exp types tenv)
  (match exp
    [(Dot left id) (hash-ref (hash-ref types (type-check-exp left types tenv)) id)] ; error messages
    [(Binary op left right) (let ([type-sig (hash-ref binary-types op)]
                                  [left (type-check-exp left types tenv)]
                                  [right (type-check-exp right types tenv)]
                                  (if (and (equal? left right) (equal? (car type-sig) left))
                                      (cdr type-sig)
                                      (error 'type-check "~e: invaid types ~e ~e" op left right))))]
    [(
    ))

(define (gather-fun-types type-set funs fun-types)
  (match funs
    ['() fun-types]
    [`(,fun . ,rst) (hash-union fun-types (make-hash `((,(Fun-id fun) . ,(extract-Fun-type fun type-set))) #:combine (lambda (a b) (error 'type-check "duplicate function name: ~e" b)))
         

(define (extract-Fun-type fun types)
  (let* [(param-types (map cdr (Fun-params fun)))
         (ret-type (Fun-ret-type fun))]
    (for ([ty param-types])
              (unless (set-member? types ty)
                (error 'type-check "unrecognized parameter type: ~e" ty)))
    (unless (or (equal? 'void ret-type) (set-member? types ret-type))
      (error 'type-check "unrecognized return type: ~e" ret-type))
    (Fun-type param-types ret-type)))

;(define (check-inv inv types tenv))




(define (build-tenv defs tenv ts)
  (match defs
    ['() tenv]
    [`((,val . ,type) . ,rest) (unless (set-member? ts type)
                                 (error 'type-check "undefined type ~e" type))
                               (if (hash-has-key? tenv val)
                                   (error 'type-check "conflicting types: ~e" val)
                                   (build-tenv rest (hash-set tenv val type) ts))]))

(define (type-error message value)
  (error 'type-check message value))


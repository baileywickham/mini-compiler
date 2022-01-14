#lang racket

(provide type-check)

(require racket/hash)
(require "ast.rkt" "util.rkt")

(struct	exn:fail:type-error exn:fail () #:transparent)

(struct Fun-type (params ret) #:transparent)

(define base-types (set 'int 'bool))
(define main-type (Fun-type '() 'int))

(define prim-types #hash((+    . (int  . int))
                         (-    . (int  . int))
                         (*    . (int  . int))
                         (/    . (int  . int))
                         (&&   . (bool . bool))
                         (\|\| . (bool . bool))
                         (<=   . (int  . bool))
                         (>=   . (int  . bool))
                         (<    . (int  . bool))
                         (>    . (int  . bool))
                         (!    . (bool . bool))))

;;
(define+ (type-check (Mini types decs funs))
  (let*
      ([type-set (set-union base-types (list->set (map Struct-id types)))]
       [fun-sigs (gather-fun-types funs type-set)]
       [structs (make-hash (map (λ+ ((Struct id flds)) (cons id (build-tenv flds type-set))) types))]
       [global-tenv (build-tenv decs type-set)])

    (for ([fun funs])
      (match-let ([(Fun id params ret-type decs body) fun])
        (let ([tenv (hash-union (build-tenv (append params decs) type-set) global-tenv
                                #:combine (λ (loc glob) loc))])
          (for ([stmt body]) (type-check-stmt stmt structs fun-sigs tenv ret-type)))

        (unless (or (equal? ret-type 'void) (always-returns? body))
          (type-error "function ~e does not return in all cases" id))))

    (let ([main (hash-ref fun-sigs 'main (λ () (type-error "could not find function main")))])
      (unless (equal? main main-type)
        (type-error "main expects no arguments and returns an int")))))

;;
(define (type-check-stmt stmt structs fun-sigs tenv ret-type)
  (match stmt
    [(? list? stmts)
     (for ([stmt stmts]) (type-check-stmt stmt structs fun-sigs tenv ret-type))]
    [(Assign target src)
     (let ([target (type-check-exp target structs fun-sigs tenv)]
           [src (type-check-exp src structs fun-sigs tenv)])
       (unless (type=? target src structs)
         (type-error "mismatched assignment types: ~e ~e" target src)))]
    [(If guard then else)
     (let ([guard (type-check-exp guard structs fun-sigs tenv)])
       (unless (equal? 'bool guard) (type-error "if guard expected bool, got ~e" guard))
       (type-check-stmt then structs fun-sigs tenv ret-type)
       (type-check-stmt else structs fun-sigs tenv ret-type))]
    [(While guard body)
     (let ([guard (type-check-exp guard structs fun-sigs tenv)])
       (unless (equal? 'bool guard) (type-error "while guard expected bool, got ~e" guard))
       (type-check-stmt body structs fun-sigs tenv ret-type))]
    [(Print exp _)
     (let ([exp (type-check-exp exp structs fun-sigs tenv)])
       (unless (equal? 'int exp) (type-error "print expected int, got ~e" exp)))]
    [(Return exp)
     (let ([exp-type (type-check-exp exp structs fun-sigs tenv)])
       (unless (type=? exp-type ret-type structs)
         (type-error "expected return type ~e got ~e" ret-type exp-type)))]
    [(Inv id args)
     (let* ([fun-type (hash-ref fun-sigs id (λ () (type-error "undefined function ~e" id)))]
            [arg-types (map (λ (a) (type-check-exp a structs fun-sigs tenv)) args)]
            [param-types (Fun-type-params fun-type)])
       (if (and (equal? (length arg-types) (length param-types))
                (andmap (λ (actual expected) (type=? expected actual structs)) arg-types param-types))
           (Fun-type-ret fun-type)
           (type-error "cound not call ~e with arguments ~e" id arg-types)))]
    [(Delete exp) (let ([exp-type (type-check-exp exp structs fun-sigs tenv)])
                    (unless (hash-has-key? structs exp-type)
                      (type-error "could not delete non struct: ~e" exp-type)))]))

;;
(define (type-check-exp exp structs fun-sigs tenv)
  (match exp
    [(Read) 'int]
    [(Null) 'null]
    [(? void?) 'void]   ;; void isn't really an exp, this will only happen in (Return void)
    [(? integer?) 'int]
    [(? boolean?) 'bool]
    [(? symbol? s) (hash-ref tenv s (λ () (type-error "unbound identifier: ~e" s)))]
    [(New id) (hash-ref-key structs id (λ () (type-error "undefined struct type: ~e" id)))]
    [(Dot left id)
     (hash-ref (hash-ref structs (type-check-exp left structs fun-sigs tenv)
                         (λ () (type-error "~e is not of struct type" left)))
               id (λ () (type-error "struct does not have member ~e" id)))]
    [(Prim (? equality-op? op) exps)
     (let ([exp-types (map (λ (e) (type-check-exp e structs fun-sigs tenv)) exps)])
       (if (and (type=? (first exp-types) (second exp-types) structs) (not (member 'bool exp-types)))
           'bool (type-error "~e: invalid types ~e" op exp-types)))]
    [(Prim op exps)
     (let ([type-sig (hash-ref prim-types op)]
           [exp-types (map (λ (e) (type-check-exp e structs fun-sigs tenv)) exps)])
       (if (andmap (λ (t) (type=? (car type-sig) t structs)) exp-types)
           (cdr type-sig)
           (type-error "~e: invalid types ~e" op exp-types)))]
    [(Inv id args)
     (let* ([fun-type (hash-ref fun-sigs id (λ () (type-error "undefined function ~e" id)))]
            [arg-types (map (λ (a) (type-check-exp a structs fun-sigs tenv)) args)]
            [param-types (Fun-type-params fun-type)])
       (if (and (equal? (length arg-types) (length param-types))
                (andmap (λ (actual expected) (type=? expected actual structs)) arg-types param-types))
           (Fun-type-ret fun-type)
           (type-error "could not call ~e with arguments ~e" id arg-types)))]))

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
(define (type=? a b structs)
  (or (equal? a b)
      (and (equal? b 'null) (hash-has-key? structs a))
      (and (equal? a 'null) (hash-has-key? structs b))))

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
(define (equality-op? op)
  (if (member op '(== !=)) #t #f))

;;
(define (type-error message . values)
  (raise (exn:fail:type-error (apply format message values) (continuation-marks #f))))

;;
(define (always-returns? stmt)
  (match stmt
    [(? Return?) #t]
    [(? list? stmts) (ormap always-returns? stmts)]
    [(If _ then else) (and (always-returns? then) (always-returns? else))]
    [_ #f]))

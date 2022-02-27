#lang racket

(provide type-check)

(require racket/hash)
(require "ast/mini.rkt" "util.rkt")

(struct	exn:fail:type-error exn:fail () #:transparent)

(struct Fun-type (params ret) #:transparent)

(define base-types
  (set 'int
       'bool))

(define prim-types
  (hash '(+    . 2) (Fun-type '(int  int)  'int)
        '(-    . 2) (Fun-type '(int  int)  'int)
        '(*    . 2) (Fun-type '(int  int)  'int)
        '(/    . 2) (Fun-type '(int  int)  'int)
        '(&&   . 2) (Fun-type '(bool bool) 'bool)
        '(\|\| . 2) (Fun-type '(bool bool) 'bool)
        '(<=   . 2) (Fun-type '(int  int)  'bool)
        '(>=   . 2) (Fun-type '(int  int)  'bool)
        '(<    . 2) (Fun-type '(int  int)  'bool)
        '(>    . 2) (Fun-type '(int  int)  'bool)

        '(!    . 1) (Fun-type '(bool) 'bool)
        '(-    . 1) (Fun-type '(int)  'int)))

(define main-type (Fun-type '() 'int))

;;
(define+ (type-check (Mini types decs funs))
  (let* ([check-type (make-check-type types)]
         [get-sig (gather-fun-types funs check-type)]
         [structs (make-hash (map (λ+ ((Struct id fs))
                                      (cons id (build-tenv fs check-type #f))) types))]
         [global-tenv (build-tenv decs check-type #t)])
    
    (unless (equal? (get-sig 'main) main-type)
      (type-error "main expects no arguments and returns an int"))
    
    (define+ (check-fun (Fun id params ret-type decs body))
      (unless (or (equal? ret-type 'void) (always-returns? body))
        (type-error "function ~e does not return in all cases" id))
      (let* ([tenv (extend-env global-tenv (build-tenv (append params decs) check-type #f))]
             [check-stmt (check-stmt* structs get-sig tenv ret-type)])
        (Fun id params ret-type decs (map check-stmt body))))

    (Mini types decs (map check-fun funs))))

;;
(define (check-stmt* structs get-sig tenv ret-type)

  (define (check-stmt stmt)
    (match stmt
      [(? list? stmts) (map check-stmt stmts)]
      [(Assign target src)
       (let ([new-target (check-exp target)]
             [new-src (check-exp src)])
         (ensure-type-match (cdr new-target) (cdr new-src) 'assignment)
         (Assign new-target new-src))]
      [(If guard then else)
       (let ([new-guard (check-exp guard)])
         (ensure-type-match 'bool (cdr new-guard) 'if)
         (If new-guard (check-stmt then) (check-stmt else)))]
      [(While guard body)
       (let ([new-guard (check-exp guard)])
         (ensure-type-match 'bool (cdr new-guard) 'while)
         (While new-guard (check-stmt body)))]
      [(Print exp endl?)
       (let ([new-exp (check-exp exp)])
         (ensure-type-match 'int (cdr new-exp) 'print)
         (Print new-exp endl?))]
      [(Return exp)
       (let ([new-exp (check-exp exp)])
         (ensure-type-match ret-type (cdr new-exp) 'return)
         (Return new-exp))]
      [(Inv id args) (car (check-fun (get-sig id) (map check-exp args) id Inv))]
      [(Delete exp)
       (let ([new-exp (check-exp exp)])
         (get-struct (cdr new-exp))  
         (Delete new-exp))]))

  ;;
  (define (check-exp exp)
    (match exp
      [(Read) (cons exp 'int)]
      [(Null) (cons exp 'null)]
      [(? void?) (cons exp 'void)]  ;; void isn't really an exp, will only happen in (Return void)
      [(? integer?) (cons exp 'int)]
      [(? boolean?) (cons exp 'bool)]
      [(? symbol? s)
       (match-let ([(cons ty global?)
                    (hash-ref tenv s (λ () (type-error "unbound identifier: ~e" s)))])
         (cons (if global? (Global s) s) ty))]
      [(New id) (cons exp (car (get-struct id)))]
      [(Dot left id)
       (let* ([new-left (check-exp left)]
              [type (car (hash-ref (cdr (get-struct (cdr new-left)))
                                   id (λ () (type-error "struct does not have member ~e" id))))])
         (cons (Dot new-left id) type))]
      [(Prim (? equality-op? op) exps)
       (let* ([new-exps (map check-exp exps)]
              [exp-types (map cdr new-exps)])
         (if (and (type=? (first exp-types) (second exp-types)) (not (member 'bool exp-types)))
             (cons (Prim op new-exps) 'bool)
             (type-error "~e: invalid types ~e" op exp-types)))]
      [(Prim op exps)
       (check-fun (hash-ref prim-types (cons op (length exps))) (map check-exp exps) op Prim)]
      [(Inv id args) (check-fun (get-sig id) (map check-exp args) id Inv)]))

  ;;
  (define (get-struct struct-id)
    (cons struct-id
          (hash-ref structs struct-id
                    (λ () (type-error "~e is not of struct type" struct-id)))))

  check-stmt)

;;
(define (ensure-type-match expected-type true-type loc)
  (unless (type=? expected-type true-type)
    (type-error "~a expected ~e, got ~e" loc expected-type true-type)))

;;
(define (type=? ty1 ty2)
  (or (equal? ty1 ty2)
      (and (equal? ty2 'null) (struct? ty1))
      (and (equal? ty1 'null) (struct? ty2))))

;;
(define (struct? type)
  (nor (equal? type 'void) (set-member? base-types type)))

;;
(define+ (check-fun (Fun-type param-types ret-type) arg-types id ast-node)
  (unless (and (equal? (length arg-types) (length param-types))
               (andmap type=? (map cdr arg-types) param-types))
    (type-error "could not call ~e with arguments ~e" id arg-types))
  (cons (ast-node id arg-types) ret-type))

;;
(define (make-check-type structs)
  (let ([all-types (set-union base-types (list->set (map Struct-id structs)))])
    (λ (possible-type)
      (unless (set-member? all-types possible-type)
        (type-error "invalid type ~e" possible-type)))))

;;
(define (gather-fun-types funs check-type)
  (let ([fun-sigs (make-hash-unique
                   (map (λ (fun) (cons (Fun-id fun) (extract-Fun-type fun check-type))) funs)
                   (λ (id) (type-error "duplicate function id ~e" id)))])
    (λ (id) (hash-ref fun-sigs id (λ () (type-error "undefined function ~e" id))))))

;;
(define+ (extract-Fun-type (Fun _ params ret-type _ _) check-type)
  (let ([param-types (map cdr params)])
    (for ([ty param-types]) (check-type ty))
    (unless (equal? 'void ret-type) (check-type ret-type))
    (Fun-type param-types ret-type)))

;;
(define (build-tenv decs check-type global?)
  (map (compose check-type cdr) decs)
  (make-hash-unique (map (λ+ ((cons id ty)) (cons id (cons ty global?))) decs)
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
(define (extend-env global-env local-env)
  (hash-union global-env local-env #:combine (λ (glob loc) loc)))

;;
(define (always-returns? stmt)
  (match stmt
    [(? Return?) #t]
    [(? list? stmts) (ormap always-returns? stmts)]
    [(If _ then else) (and (always-returns? then) (always-returns? else))]
    [_ #f]))

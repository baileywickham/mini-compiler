#lang racket

(provide translate-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt"
         racket/hash)

(define ops #hash((+    . add)
                  (*    . mul)
                  (-    . sub)
                  (/    . sdiv)
                  (&&   . and)
                  (\|\| . or)
                  (==   . eq)
                  (<=   . sle)
                  (>=   . sge)
                  (>    . sgt)
                  (<    . slt)
                  (!=   . ne)))

(struct AssignDot** (left id) #:transparent)

(define tmp-prefix 'u)
(define int-size 32)

;;
(define+ (translate-llvm (Mini types decs funs))
  (define globs (translate-decs @ decs))
  (define locs (make-immutable-hash (map (λ (dec glob) (cons (car dec) glob)) decs globs)))
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (map translate-global globs)
        (map (λ (f) (translate-fun f locs structs fun-info)) funs)))

;;
(define+ (translate-struct (Struct id fields))
  (StructLL (translate-struct-id id)
            (map (compose translate-type cdr) fields)))

;;
(define+ (translate-global (cons id ty))
  (GlobalLL id ty (if (IntLL? ty) 0 'null)))

;;
(define+ (translate-fun (Fun id params ret-type decs body) locs structs funs)
  (let* ([all-locs (hash-union locs (get-locs params decs) #:combine (λ (a b) b))]
         [blocks (map (λ (b) (translate-block b all-locs structs funs)) body)])
    (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
           (list-update blocks 0 (λ (block) (extend-block block (fun-header params decs)))))))

;;
(define+ (translate-block (Block* id stmts) locs structs funs)
  (BlockLL id (append-map (λ (s) (translate-stmt s locs structs funs)) stmts)))

;;
(define (translate-stmt s locs structs funs)
  (define stmts (box '()))
  (define add-stmt! (λ (s) (set-box! stmts (cons s (unbox stmts)))))
  (define last-stmts (translate-stmt* s (list locs structs funs add-stmt!)))
  (append (reverse (unbox stmts)) last-stmts))
 
;;
(define+ (translate-stmt* s (and context (list locs _ funs _)))
  (match s
    [(Goto* label) (list (BrLL (% label)))]
    [(GotoCond* cond iftrue iffalse)
     (let ([new-cond (car (translate-arg cond context))])
       (list (BrCondLL new-cond (% iftrue) (% iffalse))))]
    [(Return (? void?)) (list (ReturnLL 'void (void)))]
    [(Return id)
     (let ([new-ret (translate-arg id context)])
       (list (ReturnLL (cdr new-ret)  (car new-ret))))]
    [(Assign (? symbol? target) (Read))
     (let [(loc (hash-ref locs target))]
       (list (ReadLL (PtrLL (cdr loc)) (car loc))))]
    [(Assign (? symbol? target) src)
     (let ([src-arg (translate-arg src context)])
       (list (StoreLL (cdr src-arg) (car src-arg) (car (hash-ref locs target)))))]
    ;; Assign Dot
    [(Assign (? Dot? target) src)
     (let ([src-arg (translate-arg src context)]
           [target-arg (translate-arg-dot target context)])
       (list (StoreLL (cdr src-arg) (car src-arg) (car target-arg))))]
    [(Inv id args)
     (let ([new-args (map (λ (arg) (translate-arg arg context)) args)]
           [ret-type (hash-ref funs id)])
       (list (CallLL ret-type (@ id) new-args)))]
    [(Delete exp)
     (let ([new-exp (translate-arg exp context)]
           [i (make-i)])
       (list (AssignLL i (BitcastLL (cdr new-exp) (car new-exp) (PtrLL (IntLL 8))))
             (CallLL 'void (@ 'free) (list (cons i (PtrLL (IntLL 8)))))))]
    [(Print arg endl?)
     (let ([new-arg (translate-arg arg context)])
       (list (PrintLL (cdr new-arg) (car new-arg) endl?)))]))

(define+ (translate-arg-dot (Dot left id) (and context (list locs structs funs add-stmt!)))
  (let* ([left-arg (translate-arg left context)]
         [i (make-i)]
         [s (hash-ref structs (cdr left-arg))])
    (add-stmt! (AssignLL i (GetEltLL (PtrLL-to (cdr left-arg)) (car left-arg) (index-of (map car s) id))))
    (cons i (cdr (findf (λ (a) (equal? (car a) id)) s)))))

;;
(define+ (translate-arg arg (and context (list locs structs funs add-stmt!)))
  (match arg
    [(? boolean?) (cons arg (IntLL 1))]
    [(? integer?) (cons arg (IntLL int-size))]
    [(? symbol?)
     (let ([i (make-i)]
           [dec (hash-ref locs arg)])
       (add-stmt! (AssignLL i (LoadLL (cdr dec) (car dec))))
       (cons i  (cdr dec)))]
    [(Prim op (list op1 op2))
     (let ([arg1 (car (translate-arg op1 context))]
           [arg2 (car (translate-arg op2 context))]
           [i (make-i)])
       (add-stmt! (AssignLL i (BinaryLL (hash-ref ops op) (IntLL int-size) arg1 arg2)))
       (cons i (IntLL int-size)))]
    [(Prim '- (list exp))
     (let ([arg (car (translate-arg exp context))]
           [i (make-i)])
       (add-stmt! (AssignLL i (BinaryLL 'sub (IntLL int-size) 0 arg)))
       (cons i (IntLL int-size)))]
    [(Prim '! (list exp))
     (let* ([arg (translate-arg exp context)]
            [cast? (not (equal? (cdr arg) (IntLL 1)))]
            [tmp (make-i)]
            [i (make-i)])
       (when cast?
         (add-stmt! (AssignLL tmp (CastLL 'trunc (cdr arg) arg (IntLL 1)))))
       (add-stmt! (AssignLL i (BinaryLL 'xor (IntLL 1) 1 (if cast? tmp arg))))
       (cons i (IntLL 1)))]
    [(Dot left id)
     (let* ([left-arg (translate-arg left context)]
            [i (make-i)]
            [i2 (make-i)]
            [s (hash-ref structs (cdr left-arg))]
            [mem-ty (cdr (findf (λ (a) (equal? (car a) id)) s))])
       (add-stmt! (AssignLL i (GetEltLL (PtrLL-to (cdr left-arg)) (car left-arg) (index-of (map car s) id))))
       (add-stmt! (AssignLL i2 (LoadLL mem-ty i)))
       (cons i2 mem-ty))]
    [(Inv id args)
     (let ([new-args (map (λ (arg) (translate-arg arg context)) args)]
           [i (make-i)]
           [ret-type (hash-ref funs id)])
       (add-stmt! (AssignLL i (CallLL ret-type (@ id) new-args)))
       (cons i ret-type))]
    [(New id)
     (let ([i (make-i)]
           [i2 (make-i)]
           [ty (translate-type id)])
       (add-stmt! (AssignLL i (CallLL (PtrLL (IntLL 8)) (@ 'malloc)
                                      (list (cons (* 4 (length (hash-ref structs ty))) (IntLL int-size))))))
       (add-stmt! (AssignLL i2 (BitcastLL (PtrLL (IntLL 8)) i ty)))
       (cons i2 ty))]))

;;
(define (translate-type t)
  (match t
    ['void t]
    [(or 'int 'bool) (IntLL int-size)]
    [o (PtrLL (translate-struct-id o))]))

;;
(define (translate-struct-id id)
  (% (format "struct.~a" id)))

;;
(define (make-i)
  (% (make-label tmp-prefix)))

;;
(define (get-locs params decs)
  (make-immutable-hash
   (append (map cons (map car decs)
                (translate-decs % decs))
           (map cons (map car params)
                (translate-decs % (map (λ+ ((cons id ty)) (cons (param-loc id) ty)) params)))))) 

;;
(define (param-loc p)
  (format "_P_~a" p))

;;
(define (fun-header params decs)
  (append
   (map (λ+ ((cons id ty)) (AssignLL id (AllocLL ty)))
        (translate-decs %
                        (append
                         (map (λ (dec) (cons (format "_P_~a" (car dec)) (cdr dec)))
                              params)
                         decs)))
   (map (λ (dec) (StoreLL (translate-type (cdr dec))
                          (% (car dec))
                          (% (format "_P_~a" (car dec)))))
        params)))

(define+ (extend-block (BlockLL id stmts) new-stmts)
  (BlockLL id (append new-stmts stmts)))

(define (@ id) (IdLL id #t))
(define (% id) (IdLL id #f))

(define+ (get-struct-info (Struct id fields))
  (cons (translate-type id) (map (λ+ ((cons id ty)) (cons id (translate-type ty))) fields)))

(define+ (get-fun-info (Fun id _ ret-type _ _))
  (cons id (translate-type ret-type)))
  
(define (translate-decs @/% decs)
  (map (λ (dec) (translate-dec @/% dec)) decs))

(define+ (translate-dec @/% (cons id type))
  (cons (@/% id) (translate-type type)))



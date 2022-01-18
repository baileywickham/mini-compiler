#lang racket

(provide translate-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt"
         racket/hash)



(define tmp-prefix 'u)
(define int-size 32)
(define i1 (IntLL 1))
(define i8 (IntLL 8))
(define isize (IntLL int-size))

(define ops (hash '+ `(add ,isize ,isize)
                  '* `(mul ,isize ,isize)
                  '- `(sub ,isize ,isize)
                  '/ `(sdiv ,isize ,isize)
                  '&& `(and ,i1 ,i1)
                  '\|\| `(or ,i1 ,i1)
                  '== `(eq ,isize ,isize)
                  '<= `(sle ,isize ,i1)
                  '>= `(sge ,isize ,i1)
                  '> `(sgt ,isize ,i1)
                  '< `(slt ,isize ,i1)
                  '!= `(ne ,isize ,i1)))
               

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
     (let ([new-cond (car (ensure-size (translate-arg cond context) i1 context))])
       (list (BrCondLL new-cond (% iftrue) (% iffalse))))]
    [(Return (? void?)) (list (ReturnLL 'void (void)))]
    [(Return id)
     (let ([new-ret (translate-arg id context)])
       (list (ReturnLL (cdr new-ret)  (car new-ret))))]
    [(Assign (? symbol? target) (Read))
     (let [(loc (hash-ref locs target))]
       (list (ReadLL (PtrLL (cdr loc)) (car loc))))]
    [(Assign (? symbol? target) src)
     (let ([src-arg (ensure-size (translate-arg src context) isize context)])
       (list (StoreLL (cdr src-arg) (car src-arg) (car (hash-ref locs target)))))]
    ;; Assign Dot
    [(Assign (? Dot? target) src)
     (let ([src-arg (ensure-size (translate-arg src context) isize context)]
           [target-arg (translate-arg-dot target context)])
       (list (StoreLL (cdr src-arg) (car src-arg) (car target-arg))))]
    [(Inv id args)
     (let ([new-args (map (λ (arg) (translate-arg arg context)) args)]
           [ret-type (hash-ref funs id)])
       (list (CallLL ret-type (@ id) new-args)))]
    [(Delete exp)
     (let ([new-exp (translate-arg exp context)]
           [i (make-i)])
       (list (AssignLL i (CastLL 'bitcast (cdr new-exp) (car new-exp) (PtrLL i8)))
             (CallLL 'void (@ 'free) (list (cons i (PtrLL i8))))))]
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
    [(? boolean?) (cons arg i1)]
    [(? integer?) (cons arg isize)]
    [(? symbol?)
     (let ([i (make-i)]
           [dec (hash-ref locs arg)])
       (add-stmt! (AssignLL i (LoadLL (cdr dec) (car dec))))
       (cons i (cdr dec)))]
    [(Prim op (list op1 op2))
     (match-let* 
         ([(list op-name in-ty out-ty) (hash-ref ops op)]
          [arg1 (ensure-size (translate-arg op1 context) in-ty context)]
          [arg2 (ensure-size (translate-arg op2 context) in-ty context)]
          [i (make-i)])
       (add-stmt! (AssignLL i (BinaryLL op-name (cdr arg1) (car arg1) (car arg2))))
       (cons i out-ty))]
    [(Prim '- (list exp))
     (let ([arg (car (translate-arg exp context))]
           [i (make-i)])
       (add-stmt! (AssignLL i (BinaryLL 'sub isize 0 arg)))
       (cons i isize))]
    [(Prim '! (list exp))
     (let ([arg (translate-arg exp context)]
           [i (make-i)])      
       (add-stmt! (AssignLL i (BinaryLL 'xor i1 #t (car (ensure-size arg i1 context)))))
       (cons i i1))]
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
       (add-stmt! (AssignLL i (CallLL (PtrLL i8) (@ 'malloc)
                                      (list (cons (* 4 (length (hash-ref structs ty))) isize)))))
       (add-stmt! (AssignLL i2 (CastLL 'bitcast (PtrLL i8) i ty)))
       (cons i2 ty))]))

(define+ (ensure-size (and dec (cons id ty)) (and i (IntLL size)) (list _ _ _ add-stmt!))
  (match ty
    [(IntLL s)
     (if (equal? s size) dec
         (let ([tmp (make-i)])
           (add-stmt! (AssignLL tmp (CastLL (if (> s size) 'trunc 'zext) ty id i)))
           (cons tmp i)))]                  
    [_ dec]))

;;
(define (translate-type t)
  (match t
    ['void t]
    [(or 'int 'bool) isize]
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



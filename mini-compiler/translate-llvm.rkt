#lang racket

(provide translate-llvm)

(require racket/hash)
(require "ast.rkt" "util.rkt" "symbol.rkt")

(define int-size 64)
(define byte-size 8)

(define bit  (IntLL 1))
(define byte (IntLL byte-size))
(define i32  (IntLL 32))
(define int  (IntLL int-size))

(define ops (hash '+    `(add  ,int ,int)
                  '*    `(mul  ,int ,int)
                  '-    `(sub  ,int ,int)
                  '/    `(sdiv ,int ,int)
                  '&&   `(and  ,bit ,bit)
                  '\|\| `(or   ,bit ,bit)
                  '==   `(eq   ,int ,bit)
                  '<=   `(sle  ,int ,bit)
                  '>=   `(sge  ,int ,bit)
                  '>    `(sgt  ,int ,bit)
                  '<    `(slt  ,int ,bit)
                  '!=   `(ne   ,int ,bit)))

(define tmp-prefix 'u)

;;
(define+ (translate-llvm (Mini types decs funs))
  (reset-labels tmp-prefix)
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
  (match-let* ([(list new-params fun-locs fun-header) (translate-fun-vars params decs)]
               [all-locs (hash-union locs fun-locs #:combine (λ (a b) b))]
               [blocks (map (λ (b) (translate-block b all-locs structs funs)) body)])
    (FunLL (@ id) new-params (translate-type ret-type)
           (list-update blocks 0 (λ (block) (extend-block block fun-header))))))

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
(define (translate-stmt* s context)
  (match s
    [(Goto* label) (list (BrLL (% label)))]
    [(GotoCond* cond iftrue iffalse)
     (match-let ([(cons new-cond _) (ensure-type (translate-arg cond context) bit context)])
       (list (BrCondLL new-cond (% iftrue) (% iffalse))))]
    [(Return (? void?)) (list (ReturnLL 'void (void)))]
    [(Return id)
     (match-let ([(cons ret-id ret-ty) (translate-arg id context)])
       (list (ReturnLL ret-ty ret-id)))]
    [(Assign target (Read))
     (match-let ([(cons loc-id loc-ty) (translate-assign-target target context)])
       (list
        (CallLL i32 (@ 'scanf)
                (list (cons (PtrLL byte)
                            "getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0)")
                      (cons (PtrLL loc-ty) loc-id)) #t)))]
    [(Assign target src)
     (match-let ([(cons src-id _) (ensure-type (translate-arg src context) int context)]
                 [(cons target-id target-ty) (translate-assign-target target context)])
       (list (StoreLL target-ty src-id target-id)))]
    [(? Inv?)
     (match-let ([(cons call _) (translate-inv s context)])
       (list call))]
    [(Delete exp)
     (match-let ([(cons arg-id arg-ty) (translate-arg exp context)])
       (with-tmp (tmp)
         (list (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte)))
               (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
    [(Print exp endl?)
     (let ([arg (translate-arg exp context)])
       (list
        (CallLL i32 (@ 'printf)
                (list (cons (format "getelementptr inbounds ([6 x i8], [6 x i8]* @.~a, i32 0, i32 0)"
                                    (if endl? 'println 'print))
                            (PtrLL byte)) arg) #t)))]))

;;
(define+ (translate-assign-target target (and context (list locs _ _ _)))
  (if (Dot? target) (translate-dot target context) (hash-ref locs target)))

;;
(define+ (translate-arg arg (and context (list locs structs _ add-stmt!)))
  (match arg
    [(? boolean?) (cons arg bit)]
    [(? integer?) (cons arg int)]
    [(Null) (cons 'null int)]
    [(? symbol?)
     (match-let ([(cons id ty) (hash-ref locs arg)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (LoadLL ty id)))
         (cons tmp ty)))]
    [(Prim op (list op1 op2))
     (match-let*
         ([(list op-name in-ty out-ty) (hash-ref ops op)]
          [(cons arg1-id op-ty) (ensure-type (translate-arg op1 context) in-ty context)]
          [(cons arg2-id _)     (ensure-type (translate-arg op2 context) in-ty context)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (BinaryLL op-name op-ty arg1-id arg2-id)))
         (cons tmp out-ty)))]
    [(Prim '- (list exp))
     (match-let ([(cons arg-id _) (translate-arg exp context)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (BinaryLL 'sub int 0 arg-id)))
         (cons tmp int)))]
    [(Prim '! (list exp))
     (match-let ([(cons arg-id _) (ensure-type (translate-arg exp context) bit context)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (BinaryLL 'xor bit #t arg-id)))
         (cons tmp bit)))]
    [(Dot left id)
     (match-let ([(cons dot-id dot-ty) (translate-dot arg context)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (LoadLL dot-ty dot-id)))
         (cons tmp dot-ty)))]
    [(Inv id args)
     (match-let ([(cons call ret-ty) (translate-inv arg context)])
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp call))
         (cons tmp ret-ty)))]
    [(New id)
     (let* ([ty (translate-type id)]
            [size (* (/ int-size byte-size) (length (hash-ref structs ty)))])
       (with-tmp (tmp tmp2)
         (add-stmt! (AssignLL tmp (CallLL (PtrLL byte) (@ 'malloc) (list (cons size i32)) #f)))
         (add-stmt! (AssignLL tmp2 (CastLL 'bitcast (PtrLL byte) tmp ty)))
         (cons tmp2 ty)))]))

;;
(define+ (translate-dot (Dot left id) (and context (list _ structs _ add-stmt!)))
  (match-let* ([(cons left-id left-ty) (translate-arg left context)]
               [fields (hash-ref structs left-ty)])
    (with-tmp (tmp)
      (add-stmt! (AssignLL tmp (GetEltLL (PtrLL-to left-ty) left-id (index-of (map car fields) id))))
      (cons tmp (cdr (findf (λ+ ((cons mem-id _)) (equal? mem-id id)) fields))))))

;;
(define+ (translate-inv (Inv id args) (and context (list _ _ funs _)))
  (match-let*
      ([(cons ret-ty param-tys) (hash-ref funs id)]
       [new-args (map (λ (arg param-ty) (ensure-type (translate-arg arg context) param-ty context))
                      args param-tys)])
    (cons (CallLL ret-ty (@ id) new-args #f) ret-ty)))

;;
(define+ (ensure-type (and dec (cons id ty)) new-ty (list _ _ _ add-stmt!))
  (match* (ty new-ty)
    [((IntLL s) (IntLL s2))
     (if (equal? s s2) dec
         (with-tmp (tmp)
           (add-stmt! (AssignLL tmp (CastLL (if (> s s2) 'trunc 'zext) ty id new-ty)))
           (cons tmp new-ty)))]
    [(s (? IntLL?)) dec]
    [(_ _) (cons id new-ty)]))

;;
(define (translate-struct-id id)
  (% (format "struct.~a" id)))

;;
(define (translate-fun-vars params decs)
  (let* ([new-param (translate-decs % params)]
         [param-locs (translate-decs % (map (λ+ ((cons id ty)) (cons (param-loc id) ty)) params))]
         [locs (append param-locs (translate-decs % decs))])
    (list
     new-param
     (make-immutable-hash (map cons (map car (append params decs)) locs))
     (append
      (map (λ+ ((cons id ty)) (AssignLL id (AllocLL ty))) locs)
      (map (λ+ ((cons id ty) (cons loc-id _)) (StoreLL ty id loc-id)) new-param param-locs)))))

;;
(define (param-loc p)
  (format "_P_~a" p))

;;
(define+ (extend-block (BlockLL id stmts) new-stmts)
  (BlockLL id (append new-stmts stmts)))

(define (@ id) (IdLL id #t))
(define (% id) (IdLL id #f))

(define+ (get-struct-info (Struct id fields))
  (cons (translate-type id) (map (λ+ ((cons id ty)) (cons id (translate-type ty))) fields)))

(define+ (get-fun-info (Fun id params ret-type _ _))
  (list* id (translate-type ret-type) (map (compose translate-type cdr) params)))

(define (translate-decs @/% decs)
  (map (λ (dec) (translate-dec @/% dec)) decs))

(define+ (translate-dec @/% (cons id type))
  (cons (@/% id) (translate-type type)))

;;
(define (translate-type t)
  (match t
    ['void t]
    [(or 'int 'bool) int]
    [o (PtrLL (translate-struct-id o))]))

;; Macro that given a set of IDs that temporaries are needed for binds the ids to freshly
;; generated temporaries
(define-syntax (with-tmp syntax-object)
  (syntax-case syntax-object ()
    [(_ (tmp ...) body ...) #'(let ([tmp (% (make-label tmp-prefix))] ...) body ...)]))



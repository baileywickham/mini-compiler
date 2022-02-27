#lang racket

(provide stack-llvm)

(require racket/hash)
(require "ast/mini.rkt" "ast/llvm.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")


;;
(define+ (stack-llvm (Mini types decs funs))
  (reset-labels tmp-prefix)
  (define globs (translate-decs @ decs))
  (define locs (make-immutable-hash (map (λ (dec glob) (cons (car dec) glob)) decs globs)))
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (map translate-global globs)
        (map (λ (f) (translate-fun f locs structs fun-info)) funs)))

;;
(define+ (translate-fun (Fun id params ret-type decs body) locs structs funs)
  (match-let* ([(list new-params fun-locs fun-header) (translate-fun-vars params decs)]
               [all-locs (hash-union locs fun-locs #:combine (λ (a b) b))]
               [blocks (map (λ (b) (translate-block b all-locs structs funs)) body)])
    (FunLL (@ id) new-params (translate-type ret-type)
           (list-update blocks 0 (λ (block) (extend-block block fun-header))))))

;;
(define+ (translate-block (Block id stmts) locs structs funs)
  (Block id (append-map (λ (s) ((translate-stmt* locs structs funs) s)) stmts)))

;;
(define (translate-stmt* locs structs funs)
  (define stmts (box '()))

  (define (translate-stmt s)
    (match s
      [(Goto* label) (list (BrLL (% label)))]
      [(GotoCond* cond iftrue iffalse)
       (match-let ([(cons new-cond _) (ensure-type (translate-arg cond) bit)])
         (list (BrCondLL new-cond (% iftrue) (% iffalse))))]
      [(Return (? void?)) (list (ReturnLL 'void (void)))]
      [(Return id)
       (match-let ([(cons ret-id ret-ty) (translate-arg id)])
         (list (ReturnLL ret-ty ret-id)))]
      [(Assign target (Read))
       (match-let ([(cons loc-id loc-ty) (translate-assign-target target)])
         (list (CallLL i32 (@ 'scanf) (list (cons (StringConstLL 'read) (PtrLL byte))
                                            (cons loc-id (PtrLL loc-ty))) #t)))]
      [(Assign target src)
       (match-let ([(cons src-id _) (ensure-type (translate-arg src) int)]
                   [(cons target-id target-ty) (translate-assign-target target)])
         (list (StoreLL target-ty src-id target-id)))]
      [(? Inv?)
       (match-let ([(cons call _) (translate-inv s)])
         (list call))]
      [(Delete exp)
       (match-let ([(cons arg-id arg-ty) (translate-arg exp)])
         (with-tmp (tmp)
           (list (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte)))
                 (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
      [(Print exp endl?)
       (let ([arg (translate-arg exp)])
         (list (CallLL i32 (@ 'printf)
                       (list (cons (StringConstLL (if endl? 'println 'print)) (PtrLL byte))
                             arg) #t)))]))

  ;;
  (define (translate-assign-target target)
    (if (Dot? target) (translate-dot target) (hash-ref locs target)))

  ;;
  (define (translate-arg arg)
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
            [(cons arg1-id op-ty) (ensure-type (translate-arg op1) in-ty)]
            [(cons arg2-id _)     (ensure-type (translate-arg op2) in-ty)])
         (with-tmp (tmp)
           (add-stmt! (AssignLL tmp (BinaryLL op-name op-ty arg1-id arg2-id)))
           (cons tmp out-ty)))]
      [(Prim '- (list exp))
       (match-let ([(cons arg-id _) (translate-arg exp)])
         (with-tmp (tmp)
           (add-stmt! (AssignLL tmp (BinaryLL 'sub int 0 arg-id)))
           (cons tmp int)))]
      [(Prim '! (list exp))
       (match-let ([(cons arg-id _) (ensure-type (translate-arg exp) bit)])
         (with-tmp (tmp)
           (add-stmt! (AssignLL tmp (BinaryLL 'xor bit #t arg-id)))
           (cons tmp bit)))]
      [(Dot left id)
       (match-let ([(cons dot-id dot-ty) (translate-dot arg)])
         (with-tmp (tmp)
           (add-stmt! (AssignLL tmp (LoadLL dot-ty dot-id)))
           (cons tmp dot-ty)))]
      [(Inv id args)
       (match-let ([(cons call ret-ty) (translate-inv arg)])
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
  (define+ (translate-dot (Dot left id))
    (match-let* ([(cons left-id left-ty) (translate-arg left)]
                 [fields (hash-ref structs left-ty)])
      (with-tmp (tmp)
        (add-stmt! (AssignLL tmp (GetEltLL (PtrLL-to left-ty)
                                           left-id (index-of (map car fields) id))))
        (cons tmp (cdr (findf (λ+ ((cons mem-id _)) (equal? mem-id id)) fields))))))

  ;;
  (define+ (translate-inv (Inv id args))
    (match-let* ([(cons ret-ty param-tys) (hash-ref funs id)])
      (cons (CallLL ret-ty (@ id)
                    (map (λ (arg ty) (ensure-type (translate-arg arg) ty)) args param-tys) #f)
            ret-ty)))

  ;;
  (define+ (ensure-type (and dec (cons id ty)) new-ty)
    (match* (ty new-ty)
      [(type type) dec]
      [((IntLL size) (IntLL new-size))
       (with-tmp (tmp)
         (add-stmt! (AssignLL tmp (CastLL (if (> size new-size) 'trunc 'zext) ty id new-ty)))
         (cons tmp new-ty))]
      [(s (? IntLL?)) dec]
      [(_ _) (cons id new-ty)]))

  (define (add-stmt! s)
    (set-box! stmts (cons s (unbox stmts))))

  (λ (stmt)
    (let ([last-stmts (translate-stmt stmt)])
      (append (reverse (unbox stmts)) last-stmts))))

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
(define+ (extend-block (Block id stmts) new-stmts)
  (Block id (append new-stmts stmts)))
#lang racket

(provide translate-ssa-llvm)

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

(define tmp-prefix '_u)

;;
(define+ (translate-ssa-llvm (Mini types decs funs))
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
  (match-let* ([new-params (translate-decs % params)]
               [cfg (compute-preds body)])
    ((translate-cfg* locs structs funs cfg) body params)
    (FunLL (@ id) new-params (translate-type ret-type) '())))



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

;;
(define (translate-struct-id id)
  (% (format "struct.~a" id)))

;; Macro that given a set of IDs that temporaries are needed for binds the ids to freshly
;; generated temporaries
(define-syntax (with-tmp syntax-object)
  (syntax-case syntax-object ()
    [(_ (tmp ...) body ...) #'(let ([tmp (% (make-label tmp-prefix))] ...) body ...)]))


(define (compute-preds blocks)
  (define cfg (make-hash))
  (for ([block blocks])
    (hash-ref! cfg (Block*-id block) (Block-ssa (Block*-id block) '() '() '()))
    (define sucs (get-next block))
    (for ([suc sucs])
      (define b (hash-ref! cfg suc (Block-ssa suc '() '() '())))
      (set-Block-ssa-preds! b (cons (Block*-id block) (Block-ssa-preds b)))))
  cfg)


(define (get-next block)
  (match (last (Block*-stmts block))
    [(GotoCond* _ L1 L2) (list L1 L2)]
    [(Goto* L1) (list L1)]
    [_ '()]))

(define (translate-cfg* locs structs funs cfg)
  
  (define current-def (make-hash))
  (define sealed-blocks (set))

  (define (translate-cfg blocks params)
    (define first-block (hash-ref cfg (Block*-id (first blocks))))
    (for ([param params])
      (write-var (car param) first-block (translate-dec % param))) 
    (for ([block blocks])
      (define block-ssa (hash-ref cfg (Block*-id block)))
      (define translate-stmt (translate-stmt* block-ssa))
      (for ([stmt (Block*-stmts block)])
        (translate-stmt stmt))))

  (define (translate-stmt* block)
    
    (define (add-stmt! s)
      (set-Block-ssa-stmts! block (cons s (Block-ssa-stmts block))))

    (define (translate-stmt s)
      (match s
        [(Goto* label) (add-stmt! (BrLL (% label)))]
        [(GotoCond* cond iftrue iffalse)
         (match-let ([(cons new-cond _) (ensure-type (translate-arg cond) bit)])
           (add-stmt! (BrCondLL new-cond (% iftrue) (% iffalse))))]
        [(Return (? void?)) (list (ReturnLL 'void (void)))]
        [(Return id)
         (match-let ([(cons ret-id ret-ty) (translate-arg id)])
           (list (ReturnLL ret-ty ret-id)))]
        [(Assign (? symbol? target) src)
         (let ([src-val (ensure-type (translate-arg src) int )])
           (write-var target block src-val))]
        [(Assign (? Dot? target) src)
         (match-let ([(cons src-id _) (ensure-type (translate-arg src ) int )]
                     [(cons target-id target-ty) (translate-dot target)])
           (add-stmt! (StoreLL target-ty src-id target-id)))]
        [(? Inv?)
         (match-let ([(cons call _) (translate-inv s)])
           (add-stmt! call))]
        [(Delete exp)
         (match-let ([(cons arg-id arg-ty) (translate-arg exp)])
           (with-tmp (tmp)
             (add-stmt! (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte))))
             (add-stmt! (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
        [(Print exp endl?)
         (let ([arg (translate-arg exp)])
           (add-stmt!
            (CallLL i32 (@ 'printf)
                    (list (cons (format "getelementptr inbounds ([6 x i8], [6 x i8]* @.~a, i32 0, i32 0)"
                                        (if endl? 'println 'print))
                                (PtrLL byte)) arg) #t)))]))

    (define (translate-arg arg)
      (match arg
        [(? boolean?) (cons arg bit)]
        [(? integer?) (cons arg int)]
        [(Null) (cons 'null int)]
        [(? symbol?)
         (read-var arg block)]
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
             (cons tmp2 ty)))]
        [(Read)
         (with-tmp (tmp)
           (add-stmt! (CallLL i32 (@ 'scanf)
                              (list (cons "getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0)"
                                          (PtrLL byte))
                                    (cons (@ '.read_scratch (PtrLL int))) #t)))
           (add-stmt! (AssignLL tmp (LoadLL int (@ '.read_scratch))))
           (cons tmp int))]))

    ;;
    (define+ (translate-dot (Dot left id))
      (match-let* ([(cons left-id left-ty) (translate-arg left)]
                   [fields (hash-ref structs left-ty)])
        (with-tmp (tmp)
          (add-stmt! (AssignLL tmp (GetEltLL (PtrLL-to left-ty) left-id (index-of (map car fields) id))))
          (cons tmp (cdr (findf (λ+ ((cons mem-id _)) (equal? mem-id id)) fields))))))

    ;;
    (define+ (translate-inv (Inv id args))
      (match-let*
          ([(cons ret-ty param-tys) (hash-ref funs id)]
           [new-args (map (λ (arg param-ty) (ensure-type (translate-arg arg) param-ty))
                          args param-tys)])
        (cons (CallLL ret-ty (@ id) new-args #f) ret-ty)))

    ;;
    (define+ (ensure-type (and dec (cons id ty)) new-ty)
      (match* (ty new-ty)
        [((IntLL s) (IntLL s2))
         (if (equal? s s2) dec
             (with-tmp (tmp)
               (add-stmt! (AssignLL tmp (CastLL (if (> s s2) 'trunc 'zext) ty id new-ty)))
               (cons tmp new-ty)))]
        [(s (? IntLL?)) dec]
        [(_ _) (cons id new-ty)]))

    translate-stmt)


  ;; Given a var orginial name, the block id, and the value, updates current-def
  ;; returns void
  (define (write-var var block val)
    (displayln block)
    (displayln val) 
    (hash-set! (hash-ref! current-def var (make-hash)) (Block-ssa-id block) val))

  ;; Given a var original name, and the block id, returns a value that will serve as an
  ;; argument, something like an id or a number
  (define (read-var var block) 
    (if (hash-has-key? (hash-ref current-def var) block)
        (hash-ref (hash-ref current-def var) block)
        (read-var-from-pred var block)))

  (define (add-phi! block p)
    (set-Block-ssa-phis! block (cons p (Block-ssa-phis block))))

  ;; returns a value that will serve as an argument, something like an id or a number
  (define (read-var-from-pred var block)
    (define val
      (cond
        [(not (set-member? sealed-blocks block))
         ;; this CFG is not complete, the block might gain a predecessor
         ;; thus the need for a phi is unclear, so let’s assume it is needed
         (define p (Phi (make-label var) '() #f var))
         (add-phi! block p)
         ;(hash-set! (hash-ref incomplete-phis block) var p)
         (Phi-id p)]
        [(empty? (Block-ssa-preds block))
         (error 'ssa "undefined ~a" var)]
        [(empty? (rest (Block-ssa-preds block)))
         ;; there is only one predecessor (and the block is sealed)
         (read-var var (first (Block-ssa-preds block)))]
        [else
         ;; ok, let’s search through predecessors and join them
         ;; with a phi instruction at the beginning of this block
         (define p (Phi (make-label var) '() #t var))
         (write-var var block p) ;; variable maps to new value breaks cycles
         ;;^^^^^^^^ differs from paper, return value not used, so last
         ;; writeVariable is redundant along this path
         (add-phi-operands var p)
         (Phi-id p)]))
    (write-var var block val) ;; variable maps to value
    val)

  ;; (list current-def incomplete-phis sealed-blocks)


  (define (add-phi-operands var phi block)
    (for ([pred (Block-ssa-preds block)])
      (phi-append-operand phi pred (read-var var pred))))

  (define (phi-append-operand phi pred var)
    (set-Phi-args! phi (cons (cons (Block-ssa-id pred) var) (Phi-args phi))))

  ;;
  (define (seal-block block)
    ;; get target variables of all incomplete phis in this block
    (for ([phi (get-incomplete-phis block)])
      ;; for each variable, fill phi based on predecessors
      (add-phi-operands (Phi-var phi) phi block))
    (set-add sealed-blocks block))

  (define (get-incomplete-phis block)
    (filter (lambda (p) (not (Phi-complete? p))) (Block-ssa-phis block)))

  translate-cfg)


#;(define (remove-trivial-phis cfg)
    (define phis (gather-all-phis cfg))
    (define-values (trival working-set) (split-trivial phis)))


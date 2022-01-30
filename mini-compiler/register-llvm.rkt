#lang racket

(provide register-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")

(define return-var '_retval_)
(define label-prefix 'LU)
(struct Block (id [preds #:mutable] [phis #:mutable]
                  [stmts #:mutable] [sealed? #:mutable]) #:transparent)

;;
(define+ (register-llvm (Mini types decs funs))
  (reset-labels)
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (map translate-global (translate-decs @ decs))
        (map (λ (f) (translate-fun f structs fun-info)) funs)))

;;
(define+ (translate-fun (Fun id params ret-type decs body) structs fun-info)
  (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
         (translate-cfg params body structs fun-info)))

(define (add-stmt! block stmt)
  (set-Block-stmts! block (cons stmt (Block-stmts block))))

(define (add-phi! block p)
  (set-Block-phis! block (cons p (Block-phis block))))

;;
(define (translate-cfg params body structs fun-info)
  (define cfg (box '()))
  (define cfg-hash (make-hash))
  (define current-def (make-hash))
  (define (add-block! id sealed?)
    (define block (Block id '() '() '() sealed?))
    (hash-set! cfg-hash id block)
    (set-box! cfg (cons block (unbox cfg)))
    block)
  (with-labels (end-id start-id)
    (define start-block (add-block! start-id #t))
    (for ([param params])
      (write-var param start-block (translate-dec % param) (list start-block structs fun-info current-def)))
    (translate-body body start-block (Goto* end-id) (list end-id add-block! structs fun-info current-def))
    (define end-block (add-block! end-id #t))
    0)
  (unpack-cfg (unbox cfg)))

;;
(define (unpack-cfg cfg)
  (reverse (map (λ+ ((Block id _ phis stmts _))
                    (BlockLL id (append phis (reverse stmts)))) cfg)))

;;
(define+ (translate-body body current-block next (and context (list ret-id add-block! structs funs current-def)))
  (define block-context (cons current-block (cddr context)))
  (match body
    [(cons (? list? stmts) rest)
     (translate-body (append stmts rest) current-block next context)]
    [(cons (If guard then else) after)
     (with-labels (then-id else-id after-id)
       ; (BrLL (% label))
       (translate-body then (add-block! then-id #t)  (BrLL (% after-id)) context)
       (translate-body else (add-block! else-id #t) (BrLL (% after-id)) context)
       (translate-body after (add-block! after-id #t)   next context)
       (add-stmt! current-block (BrCondLL (car (ensure-type (translate-arg guard block-context) bit block-context)) (% then-id) (% else-id))))]
    [(cons (While guard while-body) after)
     (with-labels (while-id after-id)
       (translate-body while-body (add-block! while-id #f) 
                       (BrCondLL (car (ensure-type (translate-arg guard block-context) bit block-context)) (% while-id) (% after-id)) context)
       (translate-body after (add-block! after-id #t)   next context)
       (add-stmt! current-block (BrCondLL (car (ensure-type (translate-arg guard block-context) bit block-context)) (% while-id) (% after-id))))]
    [(cons (Return (? void?)) _)
     (add-stmt! current-block (BrLL (% ret-id)))]
    [(cons (Return exp) _)
     (write-var return-var current-block (translate-arg exp block-context) block-context)
     (add-stmt! current-block (BrLL (% ret-id)))]
    [(cons stmt rest)
     (translate-stmt stmt block-context )
     (translate-body rest current-block next context)]
    ['()
     (add-stmt! current-block next)]))

;;
(define+ (translate-stmt stmt (and context (list current-block structs funs current-def)))
  (match stmt
    [(Assign (and target (cons (? symbol?) _)) src)
     (let ([src-val (ensure-type (translate-arg src context) int context)])
       (write-var target current-block src-val context))]
    [(Assign (cons (? Dot? target) target-ty) src)
     (match-let ([(cons src-id _) (ensure-type (translate-arg src context) int context)]
                 [(cons target-id target-ty) (translate-dot target context)])
       (add-stmt! current-block (StoreLL target-ty src-id target-id)))]
    [(? Inv?)
     (match-let ([(cons call _) (translate-inv stmt)])
       (add-stmt! current-block call))]
    [(Delete exp)
     (match-let ([(cons arg-id arg-ty) (translate-arg exp)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte))))
         (add-stmt! current-block (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
    [(Print exp endl?)
     (let ([arg (translate-arg exp context)])
       (add-stmt! current-block
                  (CallLL i32 (@ 'printf)
                          (list (cons (format "getelementptr inbounds ([6 x i8], [6 x i8]* @.~a, i32 0, i32 0)"
                                              (if endl? 'println 'print))
                                      (PtrLL byte)) arg) #t)))]))

(define+ (translate-arg (and arg (cons arg-val arg-ty)) (and context (list current-block structs funs current-def)) )
  (match arg-val
    [(? boolean?) (cons arg-val bit)]
    [(? integer?) (cons arg-val int)]
    [(Null) (cons 'null int)]
    [(? symbol?)
     (read-var arg current-block context)]
    [(Prim op (list op1 op2))
     (match-let*
         ([(list op-name in-ty out-ty) (hash-ref ops op)]
          [(cons arg1-id op-ty) (ensure-type (translate-arg op1 context) in-ty context)]
          [(cons arg2-id _)     (ensure-type (translate-arg op2 context) in-ty context)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp (BinaryLL op-name op-ty arg1-id arg2-id)))
         (cons tmp out-ty)))]
    [(Prim '- (list exp))
     (match-let ([(cons arg-id _) (translate-arg exp context)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp (BinaryLL 'sub int 0 arg-id)))
         (cons tmp int)))]
    [(Prim '! (list exp))
     (match-let ([(cons arg-id _) (ensure-type (translate-arg exp context) bit context)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp (BinaryLL 'xor bit #t arg-id)))
         (cons tmp bit)))]
    [(Dot left id)
     (match-let ([(cons dot-id dot-ty) (translate-dot arg context)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp (LoadLL dot-ty dot-id)))
         (cons tmp dot-ty)))]
    [(Inv id args)
     (match-let ([(cons call ret-ty) (translate-inv arg)])
       (with-tmp (tmp)
         (add-stmt! current-block (AssignLL tmp call))
         (cons tmp ret-ty)))]
    [(New id)
     (let* ([ty (translate-type id)]
            [size (* (/ int-size byte-size) (length (hash-ref structs ty)))])
       (with-tmp (tmp tmp2)
         (add-stmt! current-block (AssignLL tmp (CallLL (PtrLL byte) (@ 'malloc) (list (cons size i32)) #f)))
         (add-stmt! current-block (AssignLL tmp2 (CastLL 'bitcast (PtrLL byte) tmp ty)))
         (cons tmp2 ty)))]
    [(Read)
     (with-tmp (tmp)
       (add-stmt! current-block (CallLL i32 (@ 'scanf)
                                        (list (cons "getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0)"
                                                    (PtrLL byte))
                                              (cons (@ '.read_scratch (PtrLL int))) #t)))
       (add-stmt! current-block (AssignLL tmp (LoadLL int (@ '.read_scratch))))
       (cons tmp int))]))


(define+ (translate-dot (Dot left id) (and context (list current-block structs funs current-def)))
  (match-let* ([(cons left-id left-ty) (translate-arg left context)]
               [fields (hash-ref structs left-ty)])
    (with-tmp (tmp)
      (add-stmt! current-block (AssignLL tmp (GetEltLL (PtrLL-to left-ty) left-id (index-of (map car fields) id))))
      (cons tmp (cdr (findf (λ+ ((cons mem-id _)) (equal? mem-id id)) fields))))))

;;
(define+ (translate-inv (Inv id args) (and context (list current-block structs funs current-def)))
  (match-let*
      ([(cons ret-ty param-tys) (hash-ref funs id)]
       [new-args (map (λ (arg param-ty) (ensure-type (translate-arg arg context) param-ty context))
                      args param-tys)])
    (cons (CallLL ret-ty (@ id) new-args #f) ret-ty)))

;;
(define+ (ensure-type (and dec (cons id ty)) new-ty (and context (list current-block structs funs current-def)))
  (match* (ty new-ty)
    [((IntLL s) (IntLL s2))
     (if (equal? s s2) dec
         (with-tmp (tmp)
           (add-stmt! current-block (AssignLL tmp (CastLL (if (> s s2) 'trunc 'zext) ty id new-ty)))
           (cons tmp new-ty)))]
    [(s (? IntLL?)) dec]
    [(_ _) (cons id new-ty)]))


;; Given a var orginial name, the block id, and the value, updates current-def
;; returns void
(define+ (write-var var block val (and context (list current-block structs funs current-def)))
  (displayln val) 
  (hash-set! (hash-ref! current-def var (make-hash)) (Block-id block) val))

;; Given a var original name, and the block id, returns a value that will serve as an
;; argument, something like an id or a number
(define+ (read-var var block (and context (list current-block structs funs current-def)))
  ;(pretty-display current-def)
  (displayln (hash-keys current-def))
  (displayln var)
  (if (hash-has-key? (hash-ref current-def var) (Block-id block))
      (hash-ref (hash-ref current-def var) (Block-id block))
      (read-var-from-pred var block context)))


;; returns a value that will serve as an argument, something like an id or a number
(define+ (read-var-from-pred var block (and context (list current-block structs funs current-def)))
  (define val
    (cond
      [(not (Block-sealed? block))
       ;; this CFG is not complete, the block might gain a predecessor
       ;; thus the need for a phi is unclear, so let’s assume it is needed
       (define p (Phi (make-label var) '() #f var))
       (add-phi! block p)
       ;(hash-set! (hash-ref incomplete-phis block) var p)
       (Phi-id p)]
      [(empty? (Block-preds block))
       (error 'ssa "undefined ~a" var)]
      [(empty? (rest (Block-preds block)))
       ;; there is only one predecessor (and the block is sealed)
       (read-var var (first (Block-preds block)))]
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
  (for ([pred (Block-preds block)])
    (phi-append-operand phi pred (read-var var pred))))

(define (phi-append-operand phi pred var)
  (set-Phi-args! phi (cons (cons (Block-id pred) var) (Phi-args phi))))

;;
(define (seal-block block)
  ;; get target variables of all incomplete phis in this block
  (for ([phi (get-incomplete-phis block)])
    ;; for each variable, fill phi based on predecessors
    (add-phi-operands (Phi-var phi) phi block))
  (set-Block-sealed?! block #t))

(define (get-incomplete-phis block)
  (filter (lambda (p) (not (Phi-complete? p))) (Block-phis block)))


;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label label-prefix)] ...) body ...)]))
#lang racket

(provide register-llvm)

(require "ast.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")

(define return-var '_retval_)
(define label-prefix 'LU)
(struct Block (id [phis #:mutable] [stmts #:mutable] [sealed? #:mutable]) #:transparent)

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
  (define translate-cfg (translate-cfg* structs fun-info))
  (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
         (translate-cfg params body ret-type)))

(define (add-stmt! block stmt)
  (set-Block-stmts! block (cons stmt (Block-stmts block))))

(define (add-phi! block p)
  (set-Block-phis! block (cons p (Block-phis block))))

;;
(define (unpack-cfg cfg)
  (reverse (map (λ+ ((Block id phis stmts _))
                    (BlockLL id (append phis (reverse stmts)))) cfg)))


(define (translate-cfg* structs funs)
  (define cfg (box '()))
  (define cfg-hash (make-hash))
  (define current-def (make-hash))
  (define preds (make-hash))

  (define (add-block! id sealed?)
    (define block (Block id '() '() sealed?))
    (hash-set! cfg-hash id block)
    (set-box! cfg (cons block (unbox cfg)))
    block)

  ;;
  (define (translate-body* ret-id)
    (define+ (translate-body body current-block next)
      (match body
        [(cons (? list? stmts) rest)
         (translate-body (append stmts rest) current-block next)]
        [(cons (If guard then else) after)
         (with-labels (then-id else-id after-id)
           (end-block current-block (GotoCond* guard then-id else-id))
           (translate-body then (add-block! then-id #t) (Goto* after-id))
           (translate-body else (add-block! else-id #t) (Goto* after-id))
           (translate-body after (add-block! after-id #t) next))]
        [(cons (While guard while-body) after)
         (with-labels (while-id after-id)
           (end-block current-block (GotoCond* guard while-id after-id))
           (translate-body while-body (add-block! while-id #f) (GotoCond* guard while-id after-id))
           (translate-body after (add-block! after-id #t) next))]
        [(cons (Return (? void?)) _)
         (end-block current-block (Goto* ret-id))]
        [(cons (Return exp) _)
         (write-var return-var current-block (translate-arg exp current-block))
         (end-block current-block (Goto* ret-id))]
        [(cons stmt rest)
         (translate-stmt stmt current-block)
         (translate-body rest current-block next)]
        ['()
         (end-block current-block next)]))

    translate-body)

  (define+ (end-block current-block next)
    (match next
      [(Goto* label)
       (add-stmt! current-block (BrLL (% label)))
       (add-pred current-block label)]
      [(GotoCond* cond iftrue iffalse)
       (add-stmt! current-block
                  (BrCondLL (car
                             (ensure-type (translate-arg cond current-block) bit current-block))
                            (% iftrue) (% iffalse)))
       (add-pred current-block iftrue)
       (add-pred current-block iffalse)]))

  (define (add-pred pred succ-id)
    (define current-preds (hash-ref preds succ-id '()))
    (unless (member pred current-preds)
      (hash-set! preds succ-id (cons pred current-preds))))

  ;;
  (define+ (translate-stmt stmt block)
    (match stmt
      [(Assign (and target (cons (? symbol?) _)) src)
       (let ([src-val (ensure-type (translate-arg src block) int block)])
         (write-var target block src-val))]
      [(Assign (cons (? Dot? target) target-ty) src)
       (match-let ([(cons src-id _) (ensure-type (translate-arg src block) int block)]
                   [(cons target-id target-ty) (translate-dot target block)])
         (add-stmt! block (StoreLL target-ty src-id target-id)))]
      [(? Inv?)
       (match-let ([(cons call _) (translate-inv stmt)])
         (add-stmt! block call))]
      [(Delete exp)
       (match-let ([(cons arg-id arg-ty) (translate-arg exp)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte))))
           (add-stmt! block (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
      [(Print exp endl?)
       (let ([arg (translate-arg exp block)])
         (add-stmt! block
                    (CallLL i32 (@ 'printf)
                            (list (cons (format "getelementptr inbounds ([6 x i8], [6 x i8]* @.~a, i32 0, i32 0)"
                                                (if endl? 'println 'print))
                                        (PtrLL byte)) arg) #t)))]))

  (define+ (translate-arg (and arg (cons arg-val arg-ty)) block)
    (match arg-val
      [(? boolean?) (cons arg-val bit)]
      [(? integer?) (cons arg-val int)]
      [(Null) (cons 'null int)]
      [(? symbol?)
       (read-var arg block)]
      [(Prim op (list op1 op2))
       (match-let*
           ([(list op-name in-ty out-ty) (hash-ref ops op)]
            [(cons arg1-id op-ty) (ensure-type (translate-arg op1 block) in-ty block)]
            [(cons arg2-id _)     (ensure-type (translate-arg op2 block) in-ty block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (BinaryLL op-name op-ty arg1-id arg2-id)))
           (cons tmp out-ty)))]
      [(Prim '- (list exp))
       (match-let ([(cons arg-id _) (translate-arg exp block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (BinaryLL 'sub int 0 arg-id)))
           (cons tmp int)))]
      [(Prim '! (list exp))
       (match-let ([(cons arg-id _) (ensure-type (translate-arg exp block) bit block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (BinaryLL 'xor bit #t arg-id)))
           (cons tmp bit)))]
      [(Dot left id)
       (match-let ([(cons dot-id dot-ty) (translate-dot arg block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (LoadLL dot-ty dot-id)))
           (cons tmp dot-ty)))]
      [(Inv id args)
       (match-let ([(cons call ret-ty) (translate-inv arg)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp call))
           (cons tmp ret-ty)))]
      [(New id)
       (let* ([ty (translate-type id)]
              [size (* (/ int-size byte-size) (length (hash-ref structs ty)))])
         (with-tmp (tmp tmp2)
           (add-stmt! block (AssignLL tmp (CallLL (PtrLL byte) (@ 'malloc) (list (cons size i32)) #f)))
           (add-stmt! block (AssignLL tmp2 (CastLL 'bitcast (PtrLL byte) tmp ty)))
           (cons tmp2 ty)))]
      [(Read)
       (with-tmp (tmp)
         (add-stmt! block (CallLL i32 (@ 'scanf)
                                          (list (cons "getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0)"
                                                      (PtrLL byte))
                                                (cons (@ '.read_scratch) (PtrLL int)) #t)))
         (add-stmt! block (AssignLL tmp (LoadLL int (@ '.read_scratch))))
         (cons tmp int))]))


  (define+ (translate-dot (Dot left id) block)
    (match-let* ([(cons left-id left-ty) (translate-arg left block)]
                 [fields (hash-ref structs left-ty)])
      (with-tmp (tmp)
        (add-stmt! block (AssignLL tmp (GetEltLL (PtrLL-to left-ty)
                                                 left-id (index-of (map car fields) id))))
        (cons tmp (cdr (findf (λ+ ((cons mem-id _)) (equal? mem-id id)) fields))))))

  ;;
  (define+ (translate-inv (Inv id args) block)
    (match-let*
        ([(cons ret-ty param-tys) (hash-ref funs id)]
         [new-args (map (λ (arg param-ty) (ensure-type (translate-arg arg block) param-ty block))
                        args param-tys)])
      (cons (CallLL ret-ty (@ id) new-args #f) ret-ty)))

  ;;
  (define+ (ensure-type (and dec (cons id ty)) new-ty block)
    (match* (ty new-ty)
      [((IntLL s) (IntLL s2))
       (if (equal? s s2) dec
           (with-tmp (tmp)
             (add-stmt! block (AssignLL tmp (CastLL (if (> s s2) 'trunc 'zext) ty id new-ty)))
             (cons tmp new-ty)))]
      [(s (? IntLL?)) dec]
      [(_ _) (cons id new-ty)]))


  ;; Given a var original name, the block id, and the value, updates current-def
  ;; returns void
  (define+ (write-var var block val)
    (hash-set! (hash-ref! current-def var (make-hash)) (Block-id block) val))

  ;; Given a var original name, and the block id, returns a value that will serve as an
  ;; argument, something like an id or a number
  (define+ (read-var var block)
    ;(pretty-display current-def)
    (if (hash-has-key? (hash-ref current-def var) (Block-id block))
        (hash-ref (hash-ref current-def var) (Block-id block))
        (read-var-from-pred var block)))


  ;; returns a value that will serve as an argument, something like an id or a number
  (define+ (read-var-from-pred var block)
    (define val
      (cond
        [(not (Block-sealed? block))
         ;; this CFG is not complete, the block might gain a predecessor
         ;; thus the need for a phi is unclear, so let’s assume it is needed
         (define p (Phi (make-label var) '() #f var))
         (add-phi! block p)
         ;(hash-set! (hash-ref incomplete-phis block) var p)
         (Phi-id p)]
        [(empty? (hash-ref preds (Block-id block) '()))
         (error 'ssa "undefined ~a" var)]
        [(empty? (rest (hash-ref preds (Block-id block))))
         ;; there is only one predecessor (and the block is sealed)
         (read-var var (first (hash-ref preds (Block-id block))))]
        [else
         ;; ok, let’s search through predecessors and join them
         ;; with a phi instruction at the beginning of this block
         (define p (Phi (% (make-label (car var))) (translate-type (cdr var)) '() #t var))
         (add-phi! block p)
         (write-var var block p) ;; variable maps to new value breaks cycles
         ;;^^^^^^^^ differs from paper, return value not used, so last
         ;; writeVariable is redundant along this path
         (add-phi-operands var p block)
         (cons (Phi-id p) (Phi-ty p))]))
    (write-var var block val) ;; variable maps to value
    val)

  (define+ (add-phi-operands var phi block)
    (for ([pred (hash-ref preds (Block-id block))])
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
    (filter (negate Phi-complete?) (Block-phis block)))

  (define (translate-cfg params body ret-type)
    (with-labels (end-id start-id)
      (define start-block (add-block! start-id #t))
      (for ([param params])
        (write-var param start-block (translate-dec % param)))
      ((translate-body* end-id) body start-block (Goto* end-id))
      (define end-block (add-block! end-id #t))
      (if (equal? ret-type 'void)
          (add-stmt! end-block (ReturnLL 'void (void)))
          (match-let ([(cons val _) (read-var return-var end-block)])
            (add-stmt! end-block (ReturnLL (translate-type ret-type) val)))))
    (unpack-cfg (unbox cfg)))

  translate-cfg)

;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label label-prefix)] ...) body ...)]))
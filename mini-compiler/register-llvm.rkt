#lang racket

(provide register-llvm)

(require "ast/llvm.rkt" "ast/mini.rkt" "util.rkt" "symbol.rkt" "common-llvm.rkt")


(define label-prefix 'LU)
(define read-scratch (@ '.read_scratch))

(struct Block* (id [phis #:mutable] [stmts #:mutable] [sealed? #:mutable]) #:transparent)
(struct Phi (id ty [args #:mutable] [complete? #:mutable] var) #:transparent)


;;
(define+ (register-llvm (Mini types decs funs))
  (reset-labels)
  (define structs (make-immutable-hash (map get-struct-info types)))
  (define fun-info (make-immutable-hash (map get-fun-info funs)))
  (LLVM (map translate-struct types)
        (cons (GlobalLL read-scratch int 0) (map translate-global (translate-decs @ decs)))
        (map (λ (f) (translate-fun f structs fun-info)) funs)))

;;
(define+ (translate-fun (Fun id params ret-type decs body) structs fun-info)
  (define translate-cfg (translate-cfg* structs fun-info ret-type))
  (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
         (translate-cfg params body)))

;;
(define (translate-cfg* structs funs ret-type)
  (define cfg (box '()))
  (define current-def (make-hash))
  (define preds (make-hash))

  ;;
  (define (translate-cfg params body)
    (with-labels (end-id start-id)
      (let ([start-block (add-block! start-id #t #t)])
        (for ([param params])
          (write-var param start-block (translate-dec % param)))
        ((translate-body* end-id) body start-block (Goto* end-id)))
      (let ([end-block (add-block! end-id #t)])
        (if (equal? ret-type 'void)
            (add-stmt! end-block (ReturnLL 'void (void)))
            (match-let ([(cons val _) (read-var (cons return-var ret-type) end-block)])
              (add-stmt! end-block (ReturnLL (translate-type ret-type) val)))))
      (for ([block (unbox cfg)])
        (unless (Block*-sealed? block)
          (seal-block block))))
    (unpack-cfg (unbox cfg)))

  ;;
  (define (translate-body* ret-id)
    (define (translate-body body block next)
      (when block
        (match body
          [(cons (? list? stmts) rest)
           (translate-body (append stmts rest) block next)]
          [(cons (If guard then else) after)
           (with-labels (then-id else-id after-id)
             (end-block block (GotoCond* guard then-id else-id))
             (translate-body then (add-block! then-id #t) (Goto* after-id))
             (translate-body else (add-block! else-id #t) (Goto* after-id))
             (translate-body after (add-block! after-id #t) next))]
          [(cons (While guard while-body) after)
           (with-labels (while-id after-id)
             (end-block block (GotoCond* guard while-id after-id))
             (translate-body while-body (add-block! while-id #f) (GotoCond* guard while-id after-id))
             (translate-body after (add-block! after-id #t) next))]
          [(cons (Return (cons (? void?) 'void)) _)
           (end-block block (Goto* ret-id))]
          [(cons (Return exp) _)
           (write-var (cons return-var ret-type) block
                      (ensure-type (translate-arg exp block) (translate-type ret-type) block))
           (end-block block (Goto* ret-id))]
          [(cons stmt rest)
           (translate-stmt stmt block)
           (translate-body rest block next)]
          ['()
           (end-block block next)])))
    translate-body)

  ;;
  (define (add-block! id sealed? [start? #f])
    (if (and (not start?) (empty? (hash-ref preds id '())))
        #f
        (let ([block (Block* id '() '() sealed?)])
          (set-box! cfg (cons block (unbox cfg)))
          block)))

  ;;
  (define (end-block block next)
    (match next
      [(Goto* label)
       (add-stmt! block (BrLL (% label)))
       (add-pred block label)]
      [(GotoCond* cond iftrue iffalse)
       (add-stmt! block
                  (BrCondLL (car (ensure-type (translate-arg cond block) bit block))
                            (% iftrue) (% iffalse)))
       (add-pred block iftrue)
       (add-pred block iffalse)]))

  ;;
  (define (add-pred pred succ-id)
    (define current-preds (hash-ref preds succ-id '()))
    (unless (member pred current-preds)
      (hash-set! preds succ-id (cons pred current-preds))))

  ;;
  (define (translate-stmt stmt block)
    (match stmt
      [(Assign (and target (cons (? symbol?) _)) src)
       (let ([src-val (ensure-type (translate-arg src block) int block)])
         (write-var target block src-val))]
      [(Assign (cons (? Dot? target) target-ty) src)
       (match-let ([(cons src-id _) (ensure-type (translate-arg src block) int block)]
                   [(cons target-id target-ty) (translate-dot target block)])
         (add-stmt! block (StoreLL target-ty src-id target-id)))]
      [(Assign (cons (Global target-id) target-ty) src)
       (match-let ([(cons src-id src-type) (ensure-type (translate-arg src block) int block)])
         (add-stmt! block (StoreLL (translate-type target-ty) src-id (@ target-id))))]
      [(? Inv?)
       (match-let ([(cons call _) (translate-inv stmt block)])
         (add-stmt! block call))]
      [(Delete exp)
       (match-let ([(cons arg-id arg-ty) (translate-arg exp block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (CastLL 'bitcast arg-ty arg-id (PtrLL byte))))
           (add-stmt! block (CallLL 'void (@ 'free) (list (cons tmp (PtrLL byte))) #f))))]
      [(Print exp endl?)
       (let ([arg (translate-arg exp block)])
         (add-stmt! block
                    (CallLL i32 (@ 'printf)
                            (list (cons (StringConstLL (if endl? 'println 'print)) (PtrLL byte))
                                  arg) #t)))]))

  ;;
  (define+ (translate-arg (and arg (cons arg-val arg-ty)) block)
    (match arg-val
      [(? boolean?) (cons arg-val bit)]
      [(? integer?) (cons arg-val int)]
      [(Null) (cons 'null int)]
      [(? symbol?)
       (read-var arg block)]
      [(Global id)
       (with-tmp (tmp)
         (add-stmt! block (AssignLL tmp (LoadLL (translate-type arg-ty) (@ id))))
         (cons tmp (translate-type arg-ty)))]
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
       (match-let ([(cons dot-id dot-ty) (translate-dot arg-val block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp (LoadLL dot-ty dot-id)))
           (cons tmp dot-ty)))]
      [(Inv id args)
       (match-let ([(cons call ret-ty) (translate-inv arg-val block)])
         (with-tmp (tmp)
           (add-stmt! block (AssignLL tmp call))
           (cons tmp ret-ty)))]
      [(New id)
       (let* ([ty (translate-type id)]
              [size (* (/ int-size byte-size) (length (hash-ref structs ty)))])
         (with-tmp (tmp tmp2)
           (add-stmt! block (AssignLL tmp (CallLL (PtrLL byte) (@ 'malloc)
                                                  (list (cons size i32)) #f)))
           (add-stmt! block (AssignLL tmp2 (CastLL 'bitcast (PtrLL byte) tmp ty)))
           (cons tmp2 ty)))]
      [(Read)
       (with-tmp (tmp)
         (add-stmt! block (CallLL i32 (@ 'scanf) (list (cons (StringConstLL 'read) (PtrLL byte))
                                                       (cons read-scratch (PtrLL int))) #t))
         (add-stmt! block (AssignLL tmp (LoadLL int read-scratch)))
         (cons tmp int))]))

  ;;
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
  (define (write-var var block val)
    (hash-set! (hash-ref! current-def var (make-hash)) (Block*-id block) val))

  ;; Given a var original name, and the block id, returns a value that will serve as an
  ;; argument, something like an id or a number
  (define (read-var var block)
    (hash-ref (hash-ref current-def var) (Block*-id block)
              (thunk (read-var-from-pred var block))))

  ;; returns a value that will serve as an argument, something like an id or a number
  (define (read-var-from-pred var block)
    (define val
      (if (Block*-sealed? block)
          (match (hash-ref preds (Block*-id block) '())
            ['() (error 'ssa "undefined ~a in block ~a" var block)]
            [(list pred)
             ;; there is only one predecessor (and the block is sealed)
             (read-var var pred)]
            [(? list?)
             ;; ok, let’s search through predecessors and join them
             ;; with a phi instruction at the beginning of this block
             (let-values ([(phi-node phi-var) (make-phi var block #t)])
               (write-var var block phi-var) ;; variable maps to new value breaks cycles
               ;;^^^^^^^^ differs from paper, return value not used, so last
               ;; writeVariable is redundant along this path
               (add-phi-operands var phi-node block)
               phi-var)])
          ;; this CFG is not complete, the block might gain a predecessor
          ;; thus the need for a phi is unclear, so let’s assume it is needed
          (let-values ([(_ phi-var) (make-phi var block #f)])
            phi-var)))
    (write-var var block val) ;; variable maps to value
    val)

  ;;
  (define (make-phi var block sealed?)
    (define phi (Phi (% (make-label (car var))) (translate-type (cdr var)) '() sealed? var))
    (add-phi! block phi)
    (values phi (cons (Phi-id phi) (Phi-ty phi))))

  ;;
  (define (seal-block block)
    ;; get target variables of all incomplete phis in this block
    (for ([phi (get-incomplete-phis block)])
      ;; for each variable, fill phi based on predecessors
      (add-phi-operands (Phi-var phi) phi block))
    (set-Block*-sealed?! block #t))

  ;;
  (define (add-phi-operands var phi block)
    (for ([pred (hash-ref preds (Block*-id block))])
      (phi-append-operand! phi pred (read-var var pred))))

  translate-cfg)

;;
(define (get-incomplete-phis block)
  (filter (negate Phi-complete?) (Block*-phis block)))

;;
(define (add-stmt! block stmt)
  (set-Block*-stmts! block (cons stmt (Block*-stmts block))))

;;
(define (add-phi! block phi)
  (set-Block*-phis! block (cons phi (Block*-phis block))))

;;
(define (phi-append-operand! phi pred var)
  (set-Phi-args! phi (cons (cons (Block*-id pred) var) (Phi-args phi))))

;;
(define (unpack-cfg cfg)
  (reverse (map (λ+ ((Block* id phis stmts _))
                    (Block id (append (map unpack-phi phis) (reverse stmts)))) cfg)))

;;
(define+ (unpack-phi (Phi id ty (list (cons labels ids) ...) _ _))
  (PhiLL id ty (map cons (map % labels) ids)))


;; Macro that given a set of IDs that labels are needed for binds the labels to freshly
;; generated labels
(define-syntax (with-labels syntax-object)
  (syntax-case syntax-object ()
    [(_ (label ...) body ...) #'(let ([label (make-label label-prefix)] ...) body ...)]))

#lang racket

(require "common.rkt" "../symbol.rkt")
(provide inline)

(define inline-length 4)
(define inline-count 1)
(define main-id (IdLL 'main #t))
(define builtins (set (IdLL 'printf #t)
                      (IdLL 'scanf #t)
                      (IdLL 'free #t)
                      (IdLL 'malloc #t)))

(struct InlineFun (blocks) #:transparent)

(define+ (inline (LLVM ty decs funs))
  (define inlineable
    (get-inlineable funs (get-calls funs)))
  (pretty-display (hash-keys inlineable))
  (define inline-draft ((draft-inline* inlineable) funs))
  (define clean (cleanup-cfg inline-draft))
  (LLVM ty decs clean))

(define (draft-inline* inlineable)
  (define (draft/funs funs)
    (filter (lambda (fun) (not (inlineable-id? (FunLL-id fun))))
            (map draft/fun funs)))

  (define+ (draft/fun (FunLL id params ret-ty body))
    (FunLL id params ret-ty (map draft/block body)))

  (define+ (draft/block (Block id stmts))
    (Block id (map draft/stmt stmts)))
  
  (define (draft/stmt stmt)
    (match stmt
      [(CallLL _ id args _)
       (if (inlineable-id? id)
           (make-inline args (hash-ref inlineable id) #f)
           stmt)]
      [(AssignLL target (CallLL _ id args _))
       (if (inlineable-id? id)
           (make-inline args (hash-ref inlineable id) target)
           stmt)]
      [_ stmt]))

  (define (inlineable-id? id)
    (hash-has-key? inlineable id))

  draft/funs)

(define+ (make-inline args (FunLL id params _ body) target)
  (define new-args (make-immutable-hash
                    (cons (cons (IdLL return-var #f) (or target (make-label 'unused)))
                          (map cons (map car params) (map car args)))))
  (define inline-prefix (make-label 'inline))
  (InlineFun ((inline-body* new-args inline-prefix target) body)))

(define (inline-body* new-args inline-prefix target)
  (define (inline-body blocks)
    (map inline/block blocks))
  
  (define+ (inline/block (Block id stmts))
    (Block (prefix-id id) (filter-map inline/stmt stmts)))

  (define (inline/stmt s)
    (match s
    [(AssignLL result src)
     (AssignLL (inline/arg result) (inline/stmt src))]
    [(BinaryLL op ty op1 op2)
     (BinaryLL op ty (inline/arg op1) (inline/arg op2))]
    [(BrLL label)
     (BrLL (inline/arg label))]
    [(BrCondLL cond iftrue iffalse)
     (BrCondLL (inline/arg cond) (inline/arg iftrue) (inline/arg iffalse))]
    [(StoreLL ty val ptr)
     (StoreLL ty (inline/arg val) (inline/arg ptr))]
    [(LoadLL ty ptr)
     (LoadLL ty (inline/arg ptr))]
    [(ReturnLL _ _) #f]
    #;[(ReturnLL _ (? void?)) #f]
    #;[(ReturnLL ty arg)
     (and target (AssignLL target (inline/arg arg)))]
    [(GetEltLL ty ptr index)
     (GetEltLL ty (inline/arg ptr) index)]
    [(CallLL ty fn args var-args?)
     (CallLL ty fn (map (λ+ ((cons id ty)) (cons (inline/arg id) ty)) args) var-args?)]
    [(CastLL op ty value ty2)
     (CastLL op ty (inline/arg value) ty2)]
    [(PhiLL id ty args)
     (PhiLL (inline/arg id) ty (map (λ+ ((cons label (cons id ty)))
                                        (cons (inline/arg label) (cons (inline/arg id) ty)))
                                    args))]))
  (define (inline/arg arg)
    (if (IdLL? arg)
        (hash-ref new-args arg (prefix-id arg))
        arg))      
    
  (define (prefix-id id)
    (match id
      [(IdLL id global?) (IdLL (format "~a_~a" inline-prefix id) global?)]
      [(? symbol?) (format "~a_~a" inline-prefix id)]))

  inline-body)

(define (cleanup-cfg funs)
  (map cleanup-cfg/fun funs))

(define+ (cleanup-cfg/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (append-map cleanup-cfg/block body)))

(define+ (cleanup-cfg/block (Block id stmts))
  (define-values (new-stmts rst) (cleanup-cfg/stmts stmts))
  (cons (Block id new-stmts) (append-map cleanup-cfg/block rst)))

(define+ (cleanup-cfg/stmts stmts)
  (match stmts
    [(cons (InlineFun (cons (Block id stmts) blocks)) rst)
     (values stmts (append-blocks blocks rst))]
    [(cons stmt rst)
     (let-values ([(new-rst new-blocks) (cleanup-cfg/stmts rst)])
       (values (cons stmt new-rst) new-blocks))]
    ['() (values '() '())]))
                     
  
(define (append-blocks blocks stmts)
  (list-update
   blocks (sub1 (length blocks))
   (λ+ ((Block id block-stmts)) (Block id (append block-stmts stmts)))))

(define (get-inlineable funs calls)
  (make-immutable-hash
   (map fun-hash-entry
        (filter (lambda (fun) (inlineable? fun calls)) funs))))

(define+ (fun-hash-entry fun)
  (cons (FunLL-id fun) fun))

(define+ (inlineable? (FunLL id _ _ body) calls)
  (and (= (count (negate builtin?) (get-calls/blocks body)) 0)
       (not (equal? id main-id))
       (or ((body-length body) . <= . inline-length)
           ((count (curry equal? id) calls) . <= . inline-count))))

(define (builtin? id)
  (set-member? builtins id))

(define (body-length body)
  (foldl + 0 (map (compose length Block-stmts) body)))

(define (get-calls funs)
  (append-map (compose get-calls/blocks FunLL-body) funs))

(define (get-calls/blocks blocks)
  (get-all get-calls/stmts blocks))

(define (get-calls/stmts stmt)
  (match stmt
    [(CallLL _ id _ _) (list id)]
    [(AssignLL _ (CallLL _ id _ _)) (list id)]
    [_ '()]))
  

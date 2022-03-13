#lang racket

(require "common.rkt" "../symbol.rkt")
(provide inline)

(define inline-length 4)
(define inline-count 1)
(define main-id (IdLL 'main #t))
(define builtins
  (set (IdLL 'printf #t)
       (IdLL 'scanf #t)
       (IdLL 'free #t)
       (IdLL 'malloc #t)))

(struct InlineFun (blocks) #:transparent)

(define+ (inline (LLVM ty decs funs))
  (define inlineable (get-inlineable funs))
  (pretty-display (hash-keys inlineable))
  (define inline-draft ((draft-inline* inlineable) funs))
  (define clean (cleanup-cfg inline-draft))
  (LLVM ty decs clean))

;; --------------------------------------------------------------------

(define (get-inlineable funs)
  (let ([calls (get-calls funs)])
    (make-immutable-hash
     (map fun-hash-entry
          (filter (λ (fun) (inlineable? fun calls)) funs)))))

(define (fun-hash-entry fun)
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

;; --------------------------------------------------------------------

(define (draft-inline* inlineable)

  (define (draft/funs funs)
    (map (lambda (fun) ((draft/fun*) fun))
         (filter (λ (fun) (not (inlineable-id? (FunLL-id fun)))) funs)))

  (define (draft/fun*)
    (define ret-table (make-hash))
    
    (define+ (draft/fun (FunLL id params ret-ty body))
      (define first-pass (map draft/block body))
      (pretty-display ret-table)
      (FunLL id params ret-ty (map draft/block first-pass)))

    (define+ (draft/block (Block id stmts))
      (Block id (map (lambda (stmt) (draft/stmt stmt id)) stmts)))

    (define (draft/stmt stmt block-id)
      (define new-stmt (subst-vars stmt get-var))
      (match new-stmt
        [(CallLL _ id args _)
         (if (inlineable-id? id)
             (make-inline args (hash-ref inlineable id) #f ret-table block-id)
             new-stmt)]
        [(AssignLL target (CallLL _ id args _))
         (if (inlineable-id? id)
             (make-inline args (hash-ref inlineable id) target ret-table block-id)
             new-stmt)]
        [_ new-stmt]))
    
    (define (get-var var [br? #f])
      (if (or br? (not (IdLL? var)))
          var
          (hash-ref ret-table var var)))

    draft/fun)

  (define (inlineable-id? id)
    (hash-has-key? inlineable id))

  draft/funs)

(define+ (make-inline args (FunLL id params _ body) target ret-table block-id)
  (define new-args (make-immutable-hash (cons
                                         (cons (IdLL (Block-id (first body)) #f) (IdLL block-id #f)) (map cons (map car params) (map car args)))))
  (define inline-prefix (make-label 'inline))
  (hash-set! ret-table (IdLL block-id #f) (IdLL (format "~a_~a" inline-prefix (Block-id (last body))) #f))
  (InlineFun ((inline-body* new-args inline-prefix target ret-table) body)))

(define (inline-body* new-args inline-prefix target ret-table)
  (define (inline-body blocks)
    (map inline/block blocks))

  (define+ (inline/block (Block id stmts))
    (Block (prefix-id id) (filter-map inline/stmt stmts)))

  
  (define (inline/stmt s)
    (match s
      [(ReturnLL ty arg) (hash-set! ret-table target (inline/arg arg)) #f]
      [_ (subst-vars s inline/arg)]))

    (define (inline/arg arg [br? #f])
    (match arg
      [(IdLL _ #f) (hash-ref new-args arg (prefix-id arg))]
      [_ arg]))

  (define (prefix-id id)
    (match id
      [(IdLL id global?) (IdLL (format "~a_~a" inline-prefix id) global?)]
      [(? symbol?) (format "~a_~a" inline-prefix id)]))

  inline-body)


;; --------------------------------------------------------------------

(define (cleanup-cfg funs)
  (map cleanup-cfg/fun funs))

(define+ (cleanup-cfg/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (append-map cleanup-cfg/block body)))

(define+ (cleanup-cfg/block (Block id stmts))
  (define-values (new-stmts rst) (cleanup-cfg/stmts stmts))
  (cons (Block id new-stmts) (append-map cleanup-cfg/block rst)))

(define (cleanup-cfg/stmts stmts)
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
   (λ+ ((Block id block-stmts))
       (Block id (append block-stmts stmts)))))
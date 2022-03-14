#lang racket

(provide inline)

(require "common.rkt" "../symbol.rkt")

(define inline-length 4)
(define inline-count 1)
(define main-id (IdLL 'main #t))
(define builtins
  (set (IdLL 'printf #t)
       (IdLL 'scanf #t)
       (IdLL 'free #t)
       (IdLL 'malloc #t)))

(struct InlineFun (blocks next-id) #:transparent)

;;
(define+ (inline (LLVM ty decs funs))
  (define inlineable (get-inlineable funs))
  (define inline-draft ((draft-inline* inlineable) funs))
  (define clean (cleanup-cfg inline-draft))
  (LLVM ty decs clean))

;; --------------------------------------------------------------------

;;
(define (get-inlineable funs)
  (let ([calls (get-calls funs)])
    (make-immutable-hash
     (map fun-hash-entry
          (filter (λ (fun) (inlineable? fun calls)) funs)))))

;;
(define (fun-hash-entry fun)
  (cons (FunLL-id fun) fun))

;;
(define+ (inlineable? (FunLL id _ _ body) calls)
  (and (= (count (negate builtin?) (get-calls/blocks body)) 0)
       (not (equal? id main-id))
       (or ((body-length body) . <= . inline-length)
           ((count (curry equal? id) calls) . <= . inline-count))))

;;
(define (builtin? id)
  (set-member? builtins id))

;;
(define (body-length body)
  (foldl + 0 (map (compose length Block-stmts) body)))

;;
(define (get-calls funs)
  (append-map (compose get-calls/blocks FunLL-body) funs))

;;
(define (get-calls/blocks blocks)
  (get-all get-calls/stmts blocks))

;;
(define (get-calls/stmts stmt)
  (match stmt
    [(CallLL _ id _ _) (list id)]
    [(AssignLL _ (CallLL _ id _ _)) (list id)]
    [_ '()]))

;; --------------------------------------------------------------------

;;
(define (draft-inline* inlineable)

  ;;
  (define (draft/funs funs)
    (map (lambda (fun) ((draft/fun*) fun))
         (filter (λ (fun) (not (inlineable-id? (FunLL-id fun)))) funs)))

  ;;
  (define (draft/fun*)
    (define ret-table (make-hash))

    ;;
    (define+ (draft/fun (FunLL id params ret-ty body))
      (define first-pass (map draft/block body))
      (FunLL id params ret-ty (map draft/block first-pass)))

    ;;
    (define+ (draft/block (Block id stmts))
      (Block id (map (lambda (stmt) (draft/stmt stmt id)) stmts)))

    ;;
    (define (draft/stmt stmt block-id)
      (define new-stmt (subst-vars stmt get-var))
      (match new-stmt
        [(CallLL _ (? inlineable-id? id) args _)
         (define next-id (make-label 'next))
         (hash-set! ret-table (IdLL block-id #f) (IdLL next-id #f))
         (make-inline args (hash-ref inlineable id) #f ret-table next-id)]
        [(AssignLL target (CallLL _ (? inlineable-id? id) args _))
         (define next-id (make-label 'next))
         (hash-set! ret-table (IdLL block-id #f) (IdLL next-id #f))
         (make-inline args (hash-ref inlineable id) target ret-table next-id)]
        [_ new-stmt]))

    ;;
    (define (get-var var [br? #f])
      (if (or br? (not (IdLL? var)))
          var
          (hash-ref ret-table var var)))

    draft/fun)

  ;;
  (define (inlineable-id? id)
    (hash-has-key? inlineable id))

  draft/funs)

;;
(define+ (make-inline args (FunLL id params _ body) target ret-table next-id)
  (define new-args (make-immutable-hash (map cons (map car params) (map car args))))
  (define inline-prefix (make-label 'inline))
  (InlineFun ((inline-body* new-args inline-prefix target ret-table next-id) body) next-id))

;;
(define (inline-body* new-args inline-prefix target ret-table next-id)
  (define (inline-body blocks)
    (map inline/block blocks))

  ;;
  (define+ (inline/block (Block id stmts))
    (Block (prefix-id id) (filter-map inline/stmt stmts)))

  ;;
  (define (inline/stmt s)
    (match s
      [(ReturnLL ty arg) (hash-set! ret-table target (inline/arg arg)) (BrLL (IdLL next-id #f))]
      [_ (subst-vars s inline/arg)]))

  ;;
  (define (inline/arg arg [br? #f])
    (match arg
      [(IdLL _ #f) (hash-ref new-args arg (prefix-id arg))]
      [_ arg]))

  ;;
  (define (prefix-id id)
    (match id
      [(IdLL id global?) (IdLL (format "~a_~a" inline-prefix id) global?)]
      [(or (? symbol?) (? string?)) (format "~a_~a" inline-prefix id)]))

  inline-body)


;; --------------------------------------------------------------------

;;
(define (cleanup-cfg funs)
  (map cleanup-cfg/fun funs))

;;
(define+ (cleanup-cfg/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (append-map cleanup-cfg/block body)))

;;
(define+ (cleanup-cfg/block (Block id stmts))
  (define-values (new-stmts rst) (cleanup-cfg/stmts stmts))
  (cons (Block id new-stmts) (append-map cleanup-cfg/block rst)))

;;
(define (cleanup-cfg/stmts stmts)
  (match stmts
    [(cons (InlineFun fun-blocks next-id) rst)
     (values (list (BrLL (IdLL (Block-id (first fun-blocks)) #f)))
             (append fun-blocks (list (Block next-id rst))))]
    [(cons stmt rst)
     (let-values ([(new-rst new-blocks) (cleanup-cfg/stmts rst)])
       (values (cons stmt new-rst) new-blocks))]
    ['() (values '() '())]))

;;
(define (append-blocks blocks stmts)
  (list-update
   blocks (sub1 (length blocks))
   (λ+ ((Block id block-stmts))
       (Block id (append block-stmts stmts)))))
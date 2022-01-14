#lang racket

(provide translate-llvm)

(require "ast.rkt" "util.rkt"
         racket/hash)

(define ops #hash((+    . add)
                  (*    . mul)
                  (-    . sub)
                  (/    . sdiv)
                  (&&   . and)
                  (\|\| . or)
                  (==   . eq)
                  (<=   . sle)
                  (>=   . sge)
                  (>    . sgt)
                  (<    . slt)
                  (!=   . ne)))

;;
(define+ (translate-llvm (Mini types decs funs))
  (define globs (translate-decs @ decs))
  (define locs (make-immutable-hash (map (λ (dec glob) (cons (car dec) glob)) decs globs)))
  (displayln locs)
  (LLVM (map translate-struct types)
        (map translate-global globs)
        (map (λ (f) (translate-fun f locs)) funs)))

;;
(define+ (translate-struct (Struct id fields))
  (StructLL (translate-struct-id id)
            (map (compose translate-type cdr) fields)))

;;
(define+ (translate-global (cons id ty))
  (GlobalLL id ty (if (equal? ty 'i32) 0 'null)))

;;
(define+ (translate-fun (Fun id params ret-type decs body) locs)
  (let* ([all-locs (hash-union locs (get-locs params decs) #:combine (λ (a b) b))]
         [blocks (map (λ (b) (translate-block b all-locs)) body)])
    (FunLL (@ id) (translate-decs % params) (translate-type ret-type)
           (cons
            (extend-block (first blocks) (fun-header params decs))
            (rest blocks)))))

;;
(define+ (translate-block (Block* id stmts) locs)
  (BlockLL id (append-map (λ (s) (translate-stmt s locs)) stmts)))

;;
(define (translate-stmt s locs)
  (define stmts (box '()))
  (define add-stmt! (λ (s) (set-box! stmts (cons s (unbox stmts)))))
  (match s
    [(Goto* label) (list (BrLL (% label)))]
    [(GotoCond* cond iftrue iffalse)
     (let ([new-cond (translate-arg cond locs add-stmt!)])
       (append (unbox stmts)
               (list (BrCondLL new-cond (% iftrue) (% iffalse)))))]
    [o (list o)]))

(define (translate-arg arg locs add-stmt!)
  (match arg
    [(? integer?) arg]
    [(? symbol?)
     (let ([i (make-i)])
       (add-stmt! (LoadLL i 'bad (hash-ref locs arg))) i)]
    [(Prim op (list op1 op2))
     (let ([i (make-i)])
       (add-stmt! (BinaryLL i (hash-ref ops op) 'bad (translate-arg op1 locs add-stmt!)
                            (translate-arg op2 locs add-stmt!)))
       i)]
    [o o]))

;;
(define (translate-type t)
  (match t
    ['void t]
    [(or 'int 'bool) 'i32]
    [o (PtrLL (translate-struct-id o))]))

;;
(define (translate-struct-id id)
  (% (format "struct.~a" id)))

(define (make-i)
  (% (gensym 'i)))


(define (get-locs params decs)
  (make-immutable-hash
   (append
    (map (λ (d) (cons (car d) (% (car d)))) decs)
    (map (λ (d) (cons (car d) (% (param-loc (car d))))) params))))

(define (param-loc p)
  (format "_P_~a" p))

(define (fun-header params decs)
  (append
   (map (λ (dec) (AllocLL (% (car dec)) (translate-type (cdr dec))))
        (append
         (map (λ (dec) (cons (format "_P_~a" (car dec)) (cdr dec)))
              params)
         decs))
   (map (λ (dec) (StoreLL (translate-type (cdr dec))
                          (% (car dec))
                          (% (format "_P_~a" (car dec)))))
        params)))

(define+ (extend-block (BlockLL id stmts) new-stmts)
  (BlockLL id (append new-stmts stmts)))

(define (@ id) (IdLL id #t))
(define (% id) (IdLL id #f))

(define (translate-decs @/% decs)
  (map (λ (dec) (translate-dec @/% dec)) decs))

(define+ (translate-dec @/% (cons id type))
  (cons (@/% id) (translate-type type)))



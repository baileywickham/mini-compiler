#lang racket

(provide (all-defined-out))

(require "ast/mini.rkt" "ast/llvm.rkt" "util.rkt" "symbol.rkt")



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
(define+ (translate-struct (Struct id fields))
  (StructLL (translate-struct-id id)
            (map (compose translate-type cdr) fields)))

;;
(define+ (translate-global (cons id ty))
  (GlobalLL id ty (if (IntLL? ty) 0 'null)))

;;
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


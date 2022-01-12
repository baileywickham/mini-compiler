#lang racket

(provide translate-llvm)

(require "ast.rkt")

;;
(define (translate-llvm mini*)
  (LLVM (map translate-struct (Mini-types mini*))
        '()
        (map translate-fun (Mini-funs mini*))))

;;
(define (translate-struct s)
  (StructLL (translate-struct-id (Struct-id s))
            (map (compose translate-type cdr) (Struct-fields s))))

;;
(define (translate-fun f)
  (match f
    [(Fun id params ret-type decs body)
     (let ([blocks (map translate-block body)])
       (FunLL id params (translate-type ret-type)
              (cons (first blocks) (rest blocks))))]))

;;
(define (translate-block b)
  (BlockLL (Block*-id b) (append-map translate-stmt (Block*-stmts b))))

(define (translate-type t)
  (match t
    ['void t]
    [(or 'int 'bool) 'i32]
    [o (PtrLL (translate-struct-id o))]))

(define (translate-struct-id id)
  (format "%struct.~a" id))
  

;;
(define (translate-stmt s)
  (match s
    [(Goto* label) (list (BrLL label))]
    [o (list o)]))


(define (fun-header params decs)
  (append
   (map (lambda (dec) (AllocLL (car dec) (translate-type (cdr dec))))
        (append
         (map (lambda (dec) (cons (format "%_P_~a" (car dec)) (cdr dec)))
              params)
         (map (lambda (dec) (cons (format "%~a" (car dec)) (cdr dec)))
              decs)))
   (map (lambda (dec) (
                


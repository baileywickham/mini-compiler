#lang racket

(provide translate-arm)

(require "ast.rkt" "util.rkt")

(define easy-ops
  #hash((add . add)
        (sub . sub)
        (and . and)
        (or . orr)
        (xor . eor)))

(define+ (translate-arm (LLVM tys decs funs))
  (ARM (map translate-dec decs)
       (map translate-fun funs)))

(define+ (translate-dec (GlobalLL (IdLL id _) _ _))
  (CommA id))

(define+ (translate-fun (FunLL (IdLL id _) params _ body))
  (FunA id (map translate-block body)))

(define+ (translate-block (BlockLL id stmts))
  (BlockA id (append-map translate-stmt stmts)))

(define (translate-stmt stmt)
  (match stmt
    [(BrLL (IdLL id _)) (list (BrA #f id))]
    [(BrCondLL cond (IdLL iftrue _) (IdLL iffalse _))
     (list (CmpA cond 1)
           (BrA 'eq iftrue)
           (BrA #f iffalse))]
    [(AssignLL target (BinaryLL (? easy-op? op) _ arg1 arg2))
     (list (OpA (hash-ref easy-ops op) target arg1 arg2))]
    [(AssignLL target (GetEltLL _ ptr index))
     (list (OpA 'add target ptr (* index (/ int-size byte-size))))]
    [(AssignLL target (CastLL op _ val _))
     (list (MvA #f target val))]
    [(AssignLL target (BinaryLL 'sdiv _ arg1 arg2))
     (translate-stmt (AssignLL target (CallLL #f (IdLL '__aeabi_idiv #t) (list arg1 arg2) #f)))]
    [(StoreLL _ val ptr)
     (list (StrA val ptr))]
    [o (list o)]))

(define (easy-op? op)
  (hash-has-key? easy-ops op))

#lang racket

(provide translate-arm)

(require "ast.rkt" "util.rkt")


(define+ (translate-arm (LLVM tys decs funs))
  (ARM (map translate-dec decs)
       (map translate-fun funs)))

(define+ (translate-dec (GlobalLL (IdLL id _) _ _))
  (CommA id))

(define+ (translate-fun (FunLL (IdLL id _) params _ body))
  (FunA id (map translate-block body)))

(define+ (translate-block (BlockLL id stmts))
  (BlockA id stmts))


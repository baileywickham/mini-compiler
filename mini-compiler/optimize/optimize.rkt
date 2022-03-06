#lang racket

(require "unused.rkt"
         "constant-prop.rkt"
         threading)
(provide optimize-llvm)

(define (optimize-llvm llvm)
  (~> llvm
      constant-prop
      remove-unused))
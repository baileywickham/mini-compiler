#lang racket

(require "unused.rkt"
         "constant-prop.rkt"
         "inline.rkt"
         threading)
(provide optimize-llvm)

(define (optimize-llvm llvm optimize?)
  (if optimize?
      (~> llvm
          constant-prop
          remove-unused
          inline)
      llvm))
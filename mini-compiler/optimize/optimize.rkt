#lang racket

(provide optimize-llvm)

(require "unused.rkt"
         "constant-prop.rkt"
         "inline.rkt"
         "cfg-cleanup.rkt"
         threading)

;;
(define (optimize-llvm llvm optimize?)
  (if optimize?
      (run-optimize llvm)
      llvm))

;;
(define (pass llvm)
  (~> llvm
      constant-prop
      remove-unused
      inline
      simplify-cfg))

;;
(define (run-optimize llvm)
  (define opt (pass llvm))
  (if (equal? llvm opt)
      llvm
      (run-optimize opt)))

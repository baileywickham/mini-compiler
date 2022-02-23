#lang racket

(require "ast.rkt" "util.rkt" "symbol.rkt" "live-analysis.rkt")

(provide allocate-registers)
(define+ (allocate-registers (and arm (ARM comms funs)))
  (get-live arm)
  (ARM comms funs))
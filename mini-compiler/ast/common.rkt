#lang racket/base

(provide (all-defined-out))

(struct Block (id stmts) #:transparent)

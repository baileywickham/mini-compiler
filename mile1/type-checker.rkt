#lang racket

(require "ast.rkt"
         racket/hash)
(provide type-check)


(define base-types #hash((int . #hash())
                         (bool . #hash())))
                        

(define (type-check mini)
  (displayln mini)
  (define type-set (list->set (append (hash-keys base-types) (map Struct-id (Mini-types mini)))))
  (define types (hash-union base-types
                            (make-hash (map (lambda (s) (cons (Struct-id s) (build-tenv (Struct-fields s) #hash() type-set))) (Mini-types mini)))))
  types)

(define (build-tenv defs tenv ts)
  (match defs
    ['() tenv]
    [`((,val . ,type) . ,rest) (unless (set-member? ts type)
                                 (error 'type-check "undefined type ~e" type))
                               (if (hash-has-key? tenv val)
                                   (error 'type-check "conflicting types: ~e" val)
                                   (build-tenv rest (hash-set tenv val type) ts))]))
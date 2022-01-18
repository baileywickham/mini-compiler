#lang racket

(provide reset-labels make-label)

(define symbol-table (make-hash))

;;
(define (reset-labels prefix)
  (hash-remove! symbol-table prefix))

;;
(define (make-label prefix)
  (let ([v (hash-ref! symbol-table prefix 0)])
    (hash-update! symbol-table prefix add1)
    (string->symbol (format "~a~a" prefix v))))

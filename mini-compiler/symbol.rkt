#lang racket

(provide reset-labels make-label)

(define symbol-table (make-hash))

;;
(define (reset-labels [prefix #f])
  (if prefix 
      (hash-remove! symbol-table prefix)
      (hash-clear! symbol-table)))

;;
(define (make-label prefix)
  (let ([v (hash-ref! symbol-table prefix 0)])
    (hash-update! symbol-table prefix (if (and (equal? prefix '_u) (= v 1)) (curry + 2) add1))
    ;(displayln (list prefix v)) 
    (string->symbol (format "~a~a" prefix v))))

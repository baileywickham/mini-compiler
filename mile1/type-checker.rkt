#lang racket
(require json)

(require "parse-json.rkt")

(define (main)
  (with-input-from-file "1.json"
    (lambda () (parse (read-json)))))

(main)
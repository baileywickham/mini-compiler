#lang racket
(require json)

(require "parse-json.rkt"
         "type-checker.rkt")


;; Calls the Java MiniCompiler parser and reads the generated JSON into hash tables
(define (java-parse path)
  (define-values (in out) (make-pipe))
  (define err (open-output-string))
  (define parse-ok
    (parameterize ([current-input-port (open-input-string "")]
                   [current-output-port out]
                   [current-error-port err])
      (system (string-append "java -jar MiniCompiler.jar " path))))
  (unless parse-ok (error (get-output-string err)))
  (read-json in))

(type-check (parse (java-parse "bw.mini")))
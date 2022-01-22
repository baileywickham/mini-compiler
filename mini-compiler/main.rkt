#lang racket

(provide compile)

(require json)
(require "parse-json.rkt"
         "type-check.rkt"
         "control-flow.rkt"
         "translate-llvm.rkt"
         "format-llvm.rkt"
         "ssa.rkt")

;; Main
(define (compile path stack? llvm? debug?)
  (define mini (parse (java-parse path)))
  (type-check mini)
  (define llvm-ir
    (if stack?
        (translate-llvm (control-flow mini))
        (convert-ssa (control-flow mini))))
  (when debug? (display (format-llvm llvm-ir)))
  (define llvm-path (path-replace-extension path ".ll"))
  (with-output-to-file llvm-path
    (λ () (display (format-llvm llvm-ir))) #:exists 'replace)
  (unless llvm? (clang llvm-path))
  (void))

;; Calls the Java MiniCompiler parser and reads the generated JSON into hash tables
(define (java-parse path)
  (define-values (in out) (make-pipe))
  (define err (open-output-string))
  (define parse-ok
    (parameterize ([current-input-port (open-input-string "")]
                   [current-output-port out]
                   [current-error-port err])
      (system (format "java -jar MiniCompiler.jar ~a" path))))
  (define error-message (get-output-string err))
  (unless (and parse-ok (zero? (string-length error-message))) (error error-message))
  (read-json in))

;; Calls clang on a path
(define (clang path)
  (system (format "clang ~a -o ~a" path
                  (path-replace-extension path ""))))

;; Command line argument parser
(module* main #f
  (define stack? (make-parameter #f))
  (define llvm? (make-parameter #f))
  (define debug? (make-parameter #f))

  (define mini-file
    (command-line
     #:program "mini-compiler"
     #:once-each
     [("--stack") "Compile with stack allocation" (stack? #t)]
     [("--llvm") "Compile with LLVM output" (llvm? #t)]
     [("--debug") "Compile with debugging on" (debug? #t)]
     #:args (filename) filename))

  (compile (string->path mini-file) (stack?) (llvm?) (debug?)))


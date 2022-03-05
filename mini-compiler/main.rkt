#lang racket

(provide compile)

(require json)
(require "parse-json.rkt"
         "type-check.rkt"
         "control-flow.rkt"
         "stack-llvm.rkt"
         "register-llvm.rkt"
         "format-llvm.rkt"
         "translate-arm.rkt"
         "format-arm.rkt"
         "optimize/optimize.rkt")

;; Main
(define (compile path stack? llvm? debug?)
  (define mini (parse (java-parse path)))
  (define typed-mini (type-check mini))
  (define llvm-ir
    (if stack?
        (stack-llvm (control-flow mini))
        (optimize-llvm (register-llvm typed-mini))))
  (when debug?
    (displayln (format-llvm llvm-ir)))
  (define (write-file content ext)
    (let ([new-path (path-replace-extension path ext)])
      (when debug? (display content))
      (with-output-to-file new-path (λ () (display content)) #:exists 'replace)))

  (if llvm?
        (write-file (format-llvm llvm-ir) ".ll")
        (write-file (format-arm (translate-arm llvm-ir)) ".s"))
  (assemble path llvm?)
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

(define (assemble path llvm?)
  (define out-path (if llvm?
                       (path-replace-extension path ".ll")
                       (path-replace-extension path ".s")))             
  (if llvm?
      (system (format "clang ~a -o ~a" out-path
                      (path-replace-extension path "")))
      (let [(.o (path-replace-extension path ".o"))]
        (system (format "arm-linux-gnueabi-as -o ~a ~a"
                        .o
                        out-path))
        (system (format "arm-linux-gnueabi-gcc -o ~a ~a"
                        (path-replace-extension path ".compiled")
                        .o)))))
        


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


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
(define (compile path #:stack? [stack? #f] #:llvm? [llvm? #f] #:optimize? [optimize? #f]
                 #:debug? [debug? #f] #:outpath [outpath #f] #:assemble? [assemble? #f])
  (define mini (parse (java-parse path)))
  (define typed-mini (type-check mini))
  (define llvm-ir
    (if stack?
        (stack-llvm (control-flow mini))
        (optimize-llvm (register-llvm typed-mini) optimize?)))
  (when debug?
    (displayln (format-llvm llvm-ir)))

  (define final-outpath (or outpath (path-replace-extension path (if llvm? ".ll" ".s"))))
  
  (define (write-file content)
    (when debug? (display content))
    (with-output-to-file final-outpath (λ () (display content)) #:exists 'replace))

  (if llvm?
      (write-file (format-llvm llvm-ir))
      (write-file (format-arm (translate-arm llvm-ir))))
  (when assemble?
    (assemble final-outpath llvm?))
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

(define (assemble out-path llvm?)             
  (if llvm?
      (system (format "clang ~a -o ~a" out-path
                      (path-replace-extension out-path "")))
      (let [(.o (path-replace-extension out-path ".o"))]
        (system (format "arm-linux-gnueabi-as -o ~a ~a"
                        .o
                        out-path))
        (system (format "arm-linux-gnueabi-gcc -o ~a ~a"
                        (path-replace-extension out-path ".compiled")
                        .o)))))
        
;; Command line argument parser
(module* main #f
  (define stack? (make-parameter #f))
  (define llvm? (make-parameter #f))
  (define debug? (make-parameter #f))
  (define optimize? (make-parameter #f))
  (define assemble? (make-parameter #t))

  (define mini-file
    (command-line
     #:program "mini-compiler"
     #:once-each
     [("--stack") "Compile with stack allocation" (stack? #t)]
     [("--llvm") "Compile with LLVM output" (llvm? #t)]
     [("--debug") "Compile with debugging on" (debug? #t)]
     [("--optimize") "Compile with optimizations on" (optimize? #t)]
     [("--skip-assemble") "Skip assembly step" (assemble? #f)]
     #:args (filename) filename))

  (compile (string->path mini-file) #:stack?(stack?) #:llvm?(llvm?) #:optimize?(optimize?) #:debug?(debug?)
           #:assemble?(assemble?)))


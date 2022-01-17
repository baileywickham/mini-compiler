#lang racket

(require json)
(require "parse-json.rkt"
         "type-check.rkt"
         "control-flow.rkt"
         "translate-llvm.rkt"
         "format-llvm.rkt")

;; Main
(define (compile path)
  (define mini (parse (java-parse path)))
  (type-check mini)
  (pretty-display (format-llvm (translate-llvm (control-flow mini)))))

;; Calls the Java MiniCompiler parser and reads the generated JSON into hash tables
(define (java-parse path)
  (define-values (in out) (make-pipe))
  (define err (open-output-string))
  (define parse-ok
    (parameterize ([current-input-port (open-input-string "")]
                   [current-output-port out]
                   [current-error-port err])
      (system (string-append "java -jar MiniCompiler.jar " path))))
  (define error-message (get-output-string err))
  (unless (and parse-ok (zero? (string-length error-message))) (error error-message))
  (read-json in))

(compile "mini/compat.mini")


#;(module* main #f
    (define verbose-mode (make-parameter #f))
    (define profiling-on (make-parameter #f))
    (define optimize-level (make-parameter 0))
    (define link-flags (make-parameter null))

    (define file-to-compile
      (command-line
       #:program "compiler"
       #:once-each
       [("-v" "--verbose") "Compile with verbose messages"
                           (verbose-mode #t)]
       [("-p" "--profile") "Compile with profiling"
                           (profiling-on #t)]
       #:once-any
       [("-o" "--optimize-1") "Compile with optimization level 1"
                              (optimize-level 1)]
       ["--optimize-2"        (; show help on separate lines
                               "Compile with optimization level 2,"
                               "which includes all of level 1")
                              (optimize-level 2)]
       #:multi
       [("-l" "--link-flags") lf ; flag takes one argument
                              "Add a flag <lf> for the linker"
                              (link-flags (cons lf (link-flags)))]
       #:args (filename) ; expect one command-line argument: <filename>
       ; return the argument as a filename to compile
       filename))

    (compile file-to-compile))


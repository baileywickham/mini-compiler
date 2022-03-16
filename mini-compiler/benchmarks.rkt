#lang racket

(require "main.rkt")

(define benchmark-directory "../benchmarks")

;;
(define (benchmark pat lst? error? stack? llvm? build?)
  (for ([test-name (directory-list benchmark-directory)]
        #:when (and (directory-exists? (build-path benchmark-directory test-name))
                    (regexp-match pat (path->string test-name))))
    (displayln test-name)
    (unless lst?
      (let ([content (directory-list (build-path benchmark-directory test-name) #:build? #t)])
        (if build?
            (compile-single-benchmark content)
            (run-single-benchmark content error? stack? llvm?))))))


(define (run-single-benchmark benchmark-content error? stack? llvm?)
  (define mini-file (findf (λ (file) (has-extension? file ".mini")) benchmark-content))
  (define llvm-file (path-replace-extension mini-file ".ll"))
  (define executable (if llvm?
                         (path-replace-extension mini-file "")
                         (path-replace-extension mini-file ".compiled")))

  (with-handlers ([exn:fail:filesystem? (const (void))])
    (delete-file llvm-file)
    (delete-file executable))

  (compile mini-file #:stack? stack? #:llvm? llvm? #:optimize? #t #:assemble? #t)

  (when (and error? (not (file-exists? executable)))
    (error "compilation failed"))

  (when (file-exists? executable)
    (for ([input  (filter (λ (file) (name-includes? file "input"))  benchmark-content)]
          [output (filter (λ (file) (name-includes? file "output")) benchmark-content)])
      (printf "\tinput: ~a~n\toutput:  ~a~n" input output)
      (define diff
        (with-output-to-string
          (λ () (system (format "~a < ~a | diff ~a -" (get-execute-cmd executable llvm?) input output)))))
      (unless (equal? diff "")
        ((if error? error displayln) diff)))))


(define (compile-single-benchmark benchmark-content)
  (define mini-file (findf (λ (file) (has-extension? file ".mini")) benchmark-content))
  (compile mini-file #:stack? #t #:outpath (path-replace-extension mini-file ".stack.s"))
  (compile mini-file #:outpath (path-replace-extension mini-file ".reg.s"))
  (compile mini-file #:optimize? #t #:outpath (path-replace-extension mini-file ".opt.s"))

  (compile mini-file #:llvm? #t #:stack? #t #:outpath (path-replace-extension mini-file ".stack.ll"))
  (compile mini-file #:llvm? #t #:outpath (path-replace-extension mini-file ".reg.ll"))
  (compile mini-file #:llvm? #t #:optimize? #t #:outpath (path-replace-extension mini-file ".opt.ll"))
  (void))


(define (get-execute-cmd path llvm?)
  (if llvm?
      path
      (format "qemu-arm -L /usr/arm-linux-gnueabi/ ./~a"
              path)))

;;
(define (has-extension? path ext)
  (string-suffix? (path->string path) ext))

;;
(define (name-includes? path str)
  (let-values ([(_ name _b) (split-path path)])
    (string-contains? (path->string name) str)))


;; Command line argument parser
(module* main #f
  (define list? (make-parameter #f))
  (define regexp-pattern (make-parameter #rx".*"))
  (define error? (make-parameter #f))
  (define stack? (make-parameter #f))
  (define llvm? (make-parameter #f))
  (define build? (make-parameter #f))

  (command-line
   #:program "benchmark"
   #:once-each
   [("-l" "--list") "List tests, but do not run" (list? #t)]
   [("-r" "--regexp") pat "Regexp pattern to use for test selection" (regexp-pattern (regexp pat))]
   [("-e" "--error") "Throw errors and stop on failed tests" (error? #t)]
   [("-s" "--stack") "Compile in stack mode" (stack? #t)]
   [("--llvm") "Execute LLVM-ir with clang" (llvm? #t)]
   [("--build") "Build benchmark for timing" (build? #t)])

  (benchmark (regexp-pattern) (list?) (error?) (stack?) (llvm?) (build?)))

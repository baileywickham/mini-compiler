#lang racket

(require "main.rkt")

(define benchmark-directory "../benchmarks")

;;
(define (benchmark)
  (for ([test-suite (directory-list benchmark-directory #:build? #t)]
        #:when (directory-exists? test-suite))
    (printf "testing ~a~n" test-suite)
    (define benchmark-content (directory-list test-suite #:build? #t))

    (define mini-file (findf (λ (file) (has-extension? file ".mini")) benchmark-content))
    (define llvm-file (path-replace-extension mini-file ".ll"))
    (define executable (path-replace-extension mini-file ""))
    
    (with-handlers ([exn:fail:filesystem? (const (void))])
      (delete-file llvm-file)
      (delete-file executable))

    (compile mini-file #t #f #f)
    
    (when (file-exists? executable)
      (for ([input  (filter (λ (file) (name-incules? file "input"))  benchmark-content)]
            [output (filter (λ (file) (name-incules? file "output")) benchmark-content)])
        (printf "\tinput: ~a~n\toutput:  ~a~n" input output)
        (system (format "~a < ~a | diff ~a -" executable input output))))))

;;
(define (has-extension? path ext)
  (string-suffix? (path->string path) ext))

;;
(define (name-incules? path str)
  (let-values ([(_ name _b) (split-path path)])
    (string-contains? (path->string name) str)))

(benchmark)
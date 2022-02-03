#lang racket

(provide format-arm)

(require "ast.rkt" "util.rkt")


(define header "\t.arch armv7-a\n")

(define funs-header "\n\t.text\n")

(define footer "
\t.section\t.rodata
\t.align\t2
.PRINTLN_FMT:
\t.asciz\t\"%ld\\n\"
\t.align\t2
.PRINT_FMT:
\t.asciz\t\"%ld \"
\t.align\t2
.READ_FMT:
\t.asciz\t\"%ld\"
\t.global\t__aeabi_idiv")


(define+ (format-arm (ARM comms funs))
  (string-append
   header
   (string-join (map format-comm comms) "\n")
   funs-header
   (string-join (map format-fun funs) "\n")
   footer))

(define+ (format-comm (CommA id))
  (format "\t.comm\t~a,4,4" id))

(define+ (format-fun (FunA id blocks))
  (format "\t.align 2\n\t.global ~a\n~a:\n~a\n\t.size ~a, .-~a"
          id id (string-join (map format-block blocks) "\n") id id))

(define+ (format-block (BlockA id stmts))
  (format "~a:\n~a"
          id (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) stmts) "\n")))

(define (format-stmt stmt)
  (match stmt
    [o (~v o)]))

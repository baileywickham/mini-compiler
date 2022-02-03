#lang racket
(require "ast.rkt" "util.rkt")
(provide format-arm)

(define header "\t.arch armv7-a")
(define footer "
\t.section\t.rodata
	.align	2
.PRINTLN_FMT:
	.asciz	\"%ld\\n\"
	.align	2
.PRINT_FMT:
	.asciz	\"%ld \"
	.align	2
.READ_FMT:
	.asciz	\"%ld\"
	.global	__aeabi_idiv")

(define funs-header "\t.text")

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
    [o (~a o)]))
  
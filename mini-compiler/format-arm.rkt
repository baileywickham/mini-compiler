#lang racket

(provide format-arm format-stmt format-arg)

(require "ast.rkt" "util.rkt")

(define format-strings
  #hash((read    . ".READ_FMT")
        (println . ".PRINTLN_FMT")
        (print   . ".PRINT_FMT")))

(define boiler-plate
  "\t.arch armv7-a
~a

\t.text
~a
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
\t.global\t__aeabi_idiv
")


(define+ (format-arm (ARM comms funs))
  (format boiler-plate
          (string-join (map format-comm comms) "\n")
          (string-join (map format-fun funs)   "\n")))

(define+ (format-comm (CommA id))
  (format "\t.comm\t~a,4,4" id))

(define+ (format-fun (FunA id blocks))
  (format "\t.align 2\n\t.global ~a\n~a:\n~a\n\t.size ~a, .-~a"
          id id (string-join (map format-block blocks) "\n") id id))

(define+ (format-block (BlockA id stmts))
  (format "~a:\n~a"
          (format-label id)
          (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) stmts) "\n")))

(define (format-stmt stmt)
  (match stmt
    [(BrA op id) (format "b~a ~a" (or op "") (format-label id))]
    [(CmpA arg1 arg2) (format "cmp ~a, ~a" (format-arg arg1) (format-arg arg2))]
    [(OpA op target arg1 arg2)
     (format "~a ~a, ~a, ~a" op (format-arg target) (format-arg arg1) (format-arg arg2))]
    [(MovA op target val) (format "mov~a ~a, ~a" (or op "") (format-arg target) (format-arg val))]
    [(StrA r2 addr) (format "str ~a, [~a]" (format-arg r2) (format-arg addr))]
    [(LdrA r2 addr) (format "ldr ~a, [~a]" (format-arg r2) (format-arg addr))]
    [(PushA regs) (format "push {~a}" (string-join (map format-arg regs) ", "))]
    [(PopA regs) (format "pop {~a}" (string-join (map format-arg regs) ", "))]
    [o (~v o)]))

(define (format-arg arg)
  (match arg
    [(? number?) (format "#~a" arg)]
    [(HalfA arg lower?) (format "#:~a16:~a" (if lower? "lower" "upper") (format-arg arg))]
    [(RegA r) (~a r)]
    [(? IdLL?) (format-id arg)]
    [(StringConstLL id) (hash-ref format-strings id)]
    [(? LabelA?) (format-label arg)]
    [o (~v o)]))

(define (format-label lbl)
  (match lbl
    [(LabelA l) (format ".~a" l)]
    [(? symbol?) lbl]))

(define+ (format-id (IdLL id global?))
  (format "~a~a" (if global? "@" "%") id))


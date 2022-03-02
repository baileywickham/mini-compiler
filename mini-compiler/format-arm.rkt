#lang racket

(provide format-arm format-block)

(require "ast/arm.rkt" "ast/llvm.rkt" "util.rkt")

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

(define+ (format-comm (CommDecA id))
  (format "\t.comm\t~a,4,4" id))

(define+ (format-fun (FunA id blocks))
  (format "\t.align 2\n\t.global ~a\n~a:\n~a\n\t.size ~a, .-~a"
          id id (string-join (map format-block blocks) "\n") id id))

(define+ (format-block (Block id stmts))
  (format "~a:\n~a"
          (format-label id)
          (string-join (map (λ (stmt) (format "\t~a" (format-stmt stmt))) stmts) "\n")))

(define (format-stmt stmt)
  (match stmt
    [(BrA op id) (format "b~a ~a" (or op "") (format-label id))]
    [(BlA id _) (format "bl ~a" (format-label id))]
    [(CmpA arg1 arg2) (format "cmp ~a, ~a" (format-arg arg1) (format-arg arg2))]
    [(OpA op target arg1 arg2)
     (format "~a ~a, ~a, ~a" op (format-arg target) (format-arg arg1) (format-arg arg2))]
    [(MovA op target val) (format "mov~a ~a, ~a" (or op "") (format-arg target) (format-arg val))]
    [(StrA r2 addr) (format "str ~a, [~a]" (format-arg r2) (format-arg addr))]
    [(LdrA r2 addr) (format "ldr ~a, [~a]" (format-arg r2) (format-arg addr))]
    [(PushA regs) (format "push {~a}" (string-join (map format-arg regs) ", "))]
    [(PopA regs) (format "pop {~a}" (string-join (map format-arg regs) ", "))]
    
    [(cons stmt live-after) (format "~a\t\t~a" (format-stmt stmt) (map format-live-set live-after))]
    [(PhiLL id _ args)
     (format "~a = phi ~a" (format-arg id) (string-join
                                            (map (λ+ ((cons v b))
                                                     (format "[~a ~a]" (format-arg v)
                                                             (format-label b))) args) " "))]
    [#f "<ENTRY SET>"]))

(define (format-arg arg)
  (match arg
    [(ImmA v) (format "#~a" v)]
    [(HalfA arg lower?) (format "#:~a16:~a" (if lower? "lower" "upper") (format-half-imm arg))]
    [(RegA r) (~a r)]
    [(OffsetA src offset) (format "~a, ~a" (format-arg src) (format-arg offset))]
    
    [(? IdLL?) (format-id arg)]
    [(? StackLoc?) (~a arg)]))

(define (format-half-imm imm)
  (match imm
    [(ImmA v) (~a v)]
    [(CommA id) (~a id)]))

(define (format-label lbl)
  (match lbl
    [(LabelA l) (format ".~a" l)]
    [(? symbol?) lbl]))

(define+ (format-id (IdLL id global?))
  (format "~a~a" (if global? "" "%") id))

(define (format-live-set live-set)
  (match live-set
    [(cons id l) (format "[~a ~a]" (format-arg id) (format-label l))]
    [_ (format-arg live-set)]))


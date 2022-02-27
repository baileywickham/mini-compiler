#lang racket/base

(provide (all-defined-out) (all-from-out "common.rkt"))

(require "common.rkt")

;; --------------------------------------------
;; ARM
;; --------------------------------------------

(struct ARM (comms funs) #:transparent)
(struct FunA (id blocks) #:transparent)
(struct CommA (id) #:transparent)

(struct OpA (op target r1 op2) #:transparent)
(struct CmpA (r1 op2) #:transparent)
(struct BrA (op label) #:transparent)
(struct MovA (op r1 op2) #:transparent)
(struct LdrA (r1 addr) #:transparent)
(struct StrA (r2 addr) #:transparent)
(struct PushA (regs) #:transparent)
(struct PopA (regs) #:transparent)

(struct RegA (reg) #:transparent)
(struct LabelA (lbl) #:transparent)
(struct OffsetA (reg i) #:transparent)
(struct HalfA (val lower?) #:transparent)

(define arg-regs (list (RegA 'r0) (RegA 'r1) (RegA 'r2) (RegA 'r3)))
(define callee-saved-regs (map RegA '(r4 r5 r6 r7 r8 r9 r10 r11)))


#lang racket

(provide get-live/blocks get-writes)

(require "ast/arm.rkt" "ast/llvm.rkt" "util.rkt" "format-arm.rkt")

;;
(define (get-live/blocks blocks)
  (displayln "LIVE")
  (define live-blocks (get-live/blocks* blocks (make-hash (map init-live-set blocks))))
  (displayln (string-join (map format-block live-blocks) "\n"))
  live-blocks)

;;
(define+ (init-live-set (Block id _))
  (cons id '()))

;;
(define (get-live/blocks* blocks live-sets)
  (define new-live-sets (hash-copy live-sets))
  (define live-blocks
    (map (λ+ ((Block id stmts)) 
             (define live-stmts (get-live/stmts stmts live-sets))
             (hash-set! new-live-sets id (cdr (first live-stmts)))
             (Block id live-stmts)) blocks))
  (if (equal? live-sets new-live-sets)
      live-blocks
      (get-live/blocks* blocks new-live-sets)))

;;
(define (get-live/stmts stmts live-outs)
  (match stmts
    ['() (list (cons #f '()))]
    [(cons stmt rst)
     (match-let ([(cons (cons #f live-after) rest-live-sets) (get-live/stmts rst live-outs)])
       (list* (cons #f (get-live-before stmt live-after live-outs))
              (cons stmt live-after)
              rest-live-sets))]))

;;
(define (get-live-before stmt live-after live-outs)
  (set-union (get-reads stmt live-outs)
             (set-subtract live-after (get-writes stmt))))

;;
(define (get-reads inst live-outs)
  (filter var?
          (match inst
            [(OpA _ _ r1 op2) (list r1 op2)]
            [(CmpA r1 op2) (list r1 op2)]
            [(MovA _ _ op2) (list op2)]
            [(LdrA _ op2) (list op2)]
            [(StrA r1 op2) (list r1 op2)]
            [(PhiLL _ _ args) (map car args)]
            [(BrA _ label) (hash-ref live-outs label)]
            [(BlA _ num-args) (take arg-regs (min (length arg-regs) num-args))]
            [_ '()])))

; these are more like overwrites, these overwrite the previous value in the var
(define (get-writes inst)
  (filter var?
          (match inst
            [(OpA _ target _ _) (list target)]
            [(BlA _ _) arg-regs]
            [(MovA (or #f 'w) r1 _) (list r1)]
            [(LdrA r1 _) (list r1)]
            [(PhiLL id _ _) (list id)]
            [_ '()])))

;;
(define var? (disjoin IdLL? RegA?))

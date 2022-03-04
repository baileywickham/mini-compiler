#lang racket

(provide get-live/blocks get-writes)

(require "ast/arm.rkt" "ast/llvm.rkt" "util.rkt" "format-arm.rkt")

;;
(define (get-live/blocks blocks)
  ;(displayln "LIVE")
  (define live-blocks (get-live/blocks* blocks (make-immutable-hash (map init-live-out blocks))))
  ;(displayln (string-join (map format-block live-blocks) "\n"))
  live-blocks)

;;
(define (get-live/blocks* blocks live-outs)
  (define live-blocks
    (map (λ+ ((Block id stmts))
             (Block id (get-live/stmts stmts (live-out-block live-outs)))) blocks))
  (define new-live-outs (make-immutable-hash (map get-live-out live-blocks)))
  (if (equal? live-outs new-live-outs)
      live-blocks
      (get-live/blocks* blocks new-live-outs)))

;;
(define+ (init-live-out (Block id _))
  (cons id '()))

;;
(define+ (get-live-out (Block id (cons (cons #f live-out) _)))
  (cons id live-out))

;;
(define+ (live-out-block live-outs)
  (λ (label) (hash-ref live-outs label)))

;;
(define (get-live/stmts stmts live-out)
  (match stmts
    ['() (list (cons #f '()))]
    [(cons stmt rst)
     (match-let ([(cons (cons #f live-after) rest-live-sets)
                  (get-live/stmts rst live-out)])
       (list* (cons #f (get-live-before stmt live-after live-out))
              (cons stmt live-after)
              rest-live-sets))]))

;;
(define (get-live-before stmt live-after live-out)
  (set-union (get-reads stmt live-out)
             (set-subtract live-after (get-writes stmt))))

;;
(define (get-reads inst live-out)
  (filter var?
          (match inst
            [(OpA _ _ r1 op2) (list r1 op2)]
            [(CmpA r1 op2) (list r1 op2)]
            [(MovA _ _ op2) (list op2)]
            [(LdrA _ op2) (list op2)]
            [(StrA r1 op2) (list r1 op2)]
            [(BrA _ label) (live-out label)]
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
            [_ '()])))

;;
(define var? (disjoin IdLL? RegA?))

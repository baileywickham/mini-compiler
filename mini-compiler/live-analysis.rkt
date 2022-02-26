#lang racket

(provide get-live/blocks get-writes)

(require "ast.rkt" "util.rkt" "symbol.rkt" "format-arm.rkt")

;;
(define (get-live/blocks blocks)
  (get-live/blocks* blocks (make-hash)))

;;
(define (get-live/blocks* blocks live-sets)
  (define new-live-sets (hash-copy live-sets))
  (define live-blocks
    (for/list [(block blocks)]
      (define live-stmts (get-live/stmts (BlockA-stmts block) live-sets))
      (hash-set! new-live-sets (BlockA-id block) (first live-stmts))
      (BlockA (BlockA-id block) (rest live-stmts))))
  (if (equal? live-sets new-live-sets)
      live-blocks
      (get-live/blocks* blocks new-live-sets)))

;;
(define (get-live/stmts stmts live-sets)
  (match stmts
    [(list last) (list (get-live-before last '() live-sets) (cons last '()))]
    [(cons stmt rst)
     (define live-afters (get-live/stmts rst live-sets))
     (define live-after (first live-afters))
     (define live-before (get-live-before stmt live-after live-sets))
     (list* live-before (cons stmt live-after) (rest live-afters))]))

;;
(define (get-live-before stmt live-after live-sets)
  (if (BrA? stmt)
      (set-union live-after (hash-ref live-sets (BrA-label stmt) '()))
      (set-subtract
       (set-union (get-reads stmt) live-after)
       (get-writes stmt))))

;;
(define+ (test (BlockA id stmts))
  (displayln id)
  (for [(stmt stmts)]
    (displayln stmt)
    (displayln (get-reads stmt))
    (displayln (get-writes stmt))))

;;
(define (get-reads inst)
  (filter var?
          (match inst
            [(OpA _ _ r1 op2) (list r1 op2)]
            [(CmpA r1 op2) (list r1 op2)]
            [(MovA _ _ op2) (list op2)]
            [(LdrA _ op2) (list op2)]
            ; TODO offset
            [(StrA r1 op2) (list r1 op2)]
            [(PhiLL _ _ args) (map car args)]
            [_ '()])))

; these are more like overwrites, these overwrite the previous value in the var
(define (get-writes inst)
  (filter var?
          (match inst
            [(OpA _ target _ _) (list target)]
            [(BrA 'l _) arg-regs]
            [(MovA (or #f 'l 'w) r1 _) (list r1)]
            [(LdrA r1 _) (list r1)]
            [(PhiLL id _ _) (list id)]
            [_ '()])))

;;
(define var? IdLL?)


; #;(for ((block new-blocks))
;     (displayln (BlockA-id block))
;     (for ((info (BlockA-stmts block)))
;       (displayln (format "~a\t\tlive: ~a" (format-stmt (car info)) (map format-arg (cdr info))))))
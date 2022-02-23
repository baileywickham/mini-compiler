#lang racket


(require "ast.rkt" "util.rkt" "symbol.rkt")

(provide get-live)

(define+ (get-live (ARM comms funs))
  (ARM comms (map get-live/fun funs)))

(define+ (get-live/fun (FunA id blocks))
  (displayln id)
  (for ((block blocks))
    (displayln (BlockA-id block))
    (for ((info (get-live/stmts (BlockA-stmts block))))
      (displayln (car info))
      (displayln (cdr info)))))

(define+ (get-live/stmts stmts)
  (match stmts
    [(list (and br (BrA _ label))) (list (cons br '()))]
    [(list last) (list (cons last '())) ]
    [(cons stmt rest)
     (define live-after (get-live/stmts rest))
     (define live-set (cdr (first live-after)))
     (define new-live (set-subtract (set-union (get-reads stmt) live-set)
                                    (get-writes stmt)))
     (cons (cons stmt new-live) live-after)]))


(define+ (test (BlockA id stmts))
  (displayln id)
  (for [(stmt stmts)]
    (displayln stmt)
    (displayln (get-reads stmt))
    (displayln (get-writes stmt))))

(define (get-reads inst)
  (filter var?
          (match inst
            [(OpA _ _ r1 op2) (list r1 op2)]
            [(CmpA r1 op2) (list r1 op2)]
            [(MovA _ _ op2) (list op2)]
            [(LdrA _ op2) (list op2)]
            ; TODO offset
            [(StrA r1 op2) (list r1 op2)]
            [_ '()])))

(define (get-writes inst)
  (filter var?
          (match inst
            [(OpA _ target _ _) (list target)]
            [(MovA _ r1 _) (list r1)]
            [(LdrA r1 _) (list r1)]
            [_ '()])))




(define var? IdLL?) 
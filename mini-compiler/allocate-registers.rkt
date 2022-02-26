#lang racket

(provide allocate-registers)

(require "ast.rkt"
         "util.rkt"
         "symbol.rkt"
         "live-analysis.rkt"
         graph)

;;
(define+ (allocate-registers (and arm (ARM comms funs)))
  (ARM comms (map allocate-registers/fun funs)))

;;
(define+ (allocate-registers/fun (and fun (FunA id blocks)))
  (define g (build-conflict-graph (get-live/blocks blocks)))
  (let-values ([(num-colors colored-graph) (color-graph g)])
    (displayln num-colors)
    (pretty-display colored-graph)
    ))

;;
(define (build-conflict-graph blocks)
  (unweighted-graph/undirected (append-map get-edges/block blocks)))

;;
(define+ (get-edges/block (BlockA id stmts))
  (append-map get-edges/stmt stmts))

;;
(define+ (get-edges/stmt (cons stmt live-after))
  ; handle registers
  (combinations live-after 2))

;;
(define (color-graph g)
  (coloring/greedy g))
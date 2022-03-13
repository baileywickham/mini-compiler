#lang racket

(provide allocate-registers spill-temps)

(require graph racket/hash)
(require "ast/arm.rkt" "util.rkt" "live-analysis.rkt" #;"graph-visualized.rkt" "graph.rkt")

(define-values (use-regs spill-temps) (split-at-right callee-saved-regs 2))
(define num-regs (+ (length callee-saved-regs) (length arg-regs)))

;;
(define (allocate-registers blocks)
  (define g (build-conflict-graph (get-live/blocks blocks)))
  (let* ([coloring (color-graph g)]
         [num-colors (add1 (apply max (hash-values coloring)))]
         [locations (get-locations-mapping coloring (get-locations coloring num-colors))])
    (values num-colors locations)))

;;
(define (build-conflict-graph blocks)
  (unweighted-graph/undirected
   (append (append-map get-edges/block blocks)
           (combinations arg-regs 2))))

;;
(define+ (get-edges/block (Block id stmts))
  (append-map get-edges/stmt stmts))

;;
(define+ (get-edges/stmt (cons stmt live-after))
  (define reg-writes (if (BlA? stmt) arg-regs '()))
  (append live-after
          (combinations (set-union live-after reg-writes) 2)))

;;
#;(define (color-graph g)
    (coloring/greedy g))

;;
(define (get-locations coloring num-colors)
  (define locs (make-immutable-hash (map (λ (reg) (cons (hash-ref coloring reg) reg)) arg-regs)))
  (hash-union
   (make-immutable-hash
    (map-indexed
     (λ (color i) (cons color (get-location i num-colors)))
     (filter (λ (c) (not (hash-has-key? locs c))) (range num-colors))))
   locs))

(define (get-location i num-colors)
  (cond
    [(and (num-colors . > . num-regs) (i . >= . (length use-regs)))
     (StackLoc 'spill i)]
    [else (list-ref callee-saved-regs i)]))

(define (get-locations-mapping coloring locations)
  (make-immutable-hash
   (hash-map coloring (λ (id color) (cons id (hash-ref locations color))))))

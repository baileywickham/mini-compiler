#lang racket

(provide allocate-registers)

(require graph racket/hash)
(require "ast.rkt" "util.rkt" "symbol.rkt" "live-analysis.rkt")


;;
(define (allocate-registers blocks)
  ;(pretty-display (get-live/blocks blocks))
  (define g (build-conflict-graph (get-live/blocks blocks)))
  (let*-values ([(num-colors coloring) (color-graph g)]
                [(locations) (get-locations-mapping coloring (get-locations coloring num-colors))])
    ;(displayln num-colors)
    ;(pretty-display locations)
    ;(pretty-display coloring)
    ;(pretty-display blocks)
    (cons num-colors locations)))

;;
(define (build-conflict-graph blocks)
  (unweighted-graph/undirected (append (append-map get-edges/block blocks)
                                       (combinations arg-regs 2))))

;;
(define+ (get-edges/block (BlockA id stmts))
  (append-map get-edges/stmt stmts))

;;
(define+ (get-edges/stmt (cons stmt live-after))
  (define reg-writes (filter RegA? (get-writes stmt)))
  (combinations (set-union live-after reg-writes) 2))

;;
(define (color-graph g)
  (coloring/greedy g))

(define (get-locations coloring num-colors)
  (define locs (make-immutable-hash (map (lambda (reg) (cons (hash-ref coloring reg) reg)) arg-regs)))
  (hash-union 
   (make-immutable-hash (map-indexed
                         (lambda (color i) (displayln color) (displayln i) (cons color (get-location i)))
                         (filter (lambda (c) (not (hash-has-key? locs c))) (range num-colors))))
   locs))

(define (get-location i)
  (if (< i (length callee-saved-regs)) 
      (list-ref callee-saved-regs i)
      ;; Add stack support
      (void)))

(define (get-locations-mapping coloring locations)
  (make-immutable-hash (hash-map coloring (lambda (id color) (cons id (hash-ref locations color))))))
#lang racket

(require graph)
(require racket/set racket/function racket/unsafe/ops data/heap)
(define-syntax-rule (unsafe-add1 x) (unsafe-fx+ x 1))
(require racket/stxparam racket/unsafe/ops)
(define-syntax-rule (unsafe-add1! x) (set! x (unsafe-add1 x)))



(provide color-graph build-graph)

(define (color-graph G)
  (define num-colors 0)
  (define-vertex-property G color)
  (define vs (get-vertices G))
  (define ordered-vs (order-smallest-last G))
  (define num-vs (length vs)) 
  (for ([u ordered-vs])
    (define used-colors 
      (for/set ([v (in-neighbors G u)]) (color v #:default num-vs)))
    (define smallest-color
      (for/last ([smallest-color (in-range num-vs)]
                 #:final (not (set-member? used-colors smallest-color)))
        smallest-color))
    (color-set! u smallest-color)
    (when (= smallest-color num-colors) (unsafe-add1! num-colors)))
  (values num-colors (color->hash)))

(define (order-smallest-last G)
  (define-vertex-property G deg 
    #:init (length (get-neighbors G $v)))
  (define H (make-heap (λ (x y) (< (deg x) (deg y)))))
  (heap-add-all! H (get-vertices G))
  (define in-H (apply set (get-vertices G)))
  (let loop ([res null])
    (cond 
      [(set-empty? in-H) res]
      [else
       (let remove-loop ()
         (unless (set-member? in-H (heap-min H)) 
           (heap-remove-min! H) (remove-loop)))
       (define min-v (heap-min H))
       (heap-remove-min! H)
       (set! in-H (set-remove in-H min-v))
       (for ([v (in-neighbors G min-v)]) 
         (deg-set! v (sub1 (deg v)))
         (heap-add! H v))
       (loop (cons min-v res))])))

(define (build-graph g)
  (unweighted-graph/undirected g))
#lang racket

(require graph
         data/heap)
(provide color-graph build-graph)

(define (color-graph graph)
  (define num-colors 0)
  (define-vertex-property G color)
  (define vs (get-vertices graph))
  (define ordered-vs (smallest-last graph))
  (define num-vs (length vs))
  (for ([u ordered-vs])
    (define used-colors 
      (for/set ([v (in-neighbors graph u)]) (color v #:default num-vs)))
    (define smallest-color
      (for/last ([smallest-color (in-range num-vs)]
                 #:final (not (set-member? used-colors smallest-color)))
        smallest-color))
    (color-set! u smallest-color)
    (when (= smallest-color num-colors) (add1 num-colors)))
  (values num-colors (color->hash)))


(define (smallest-last graph)
  (define-vertex-property graph deg 
    #:init (length (get-neighbors graph $v)))
  (define H (make-heap (λ (x y) (< (deg x) (deg y)))))
  (heap-add-all! H (get-vertices graph))
  (define in-H (apply set (get-vertices graph)))
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
       (for ([v (in-neighbors graph min-v)]) 
         (deg-set! v (sub1 (deg v)))
         (heap-add! H v))
       (loop (cons min-v res))])))

(define (build-graph g)
  (unweighted-graph/undirected g))
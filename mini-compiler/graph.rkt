#lang racket

(require graph)
(require data/heap)

(provide color-graph)

(define (color-graph graph)
  (define-vertex-property graph color)
  (let ([vert-count (length (get-vertices graph))])
    (for ([next (order graph)])
      (define bad-colors 
        (for/set ([v (in-neighbors graph next)]) (color v #:default vert-count)))
      (define smallest-color
        (for/last ([smallest-color (in-range vert-count)]
                   #:final (not (set-member? bad-colors smallest-color)))
          smallest-color))
      (color-set! next smallest-color))
    (color->hash)))

(define (order graph)
  (define new-graph (graph-copy graph))
  (get-ordering new-graph))

(define (get-ordering graph)
  (define in-vert (get-vertices graph))
  (cond
    [(empty? in-vert) '()]
    [else
     (define max-deg (argmax (lambda (v) (length (get-neighbors graph v))) in-vert))
     (remove-vertex! graph max-deg)
     (cons max-deg (get-ordering graph))]))    
  
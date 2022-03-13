#lang racket

(require graph)
(require data/heap)

(provide color-graph)

(define (color-graph graph)
  (define-vertex-property graph color)
  (let* ([color-box (box 0)]
         [vert-count (length (get-vertices graph))])
    (for ([u (order-smallest-last graph)])
      (define used-colors 
        (for/set ([v (in-neighbors graph u)]) (color v #:default vert-count)))
      (define smallest-color
        (for/last ([smallest-color (in-range vert-count)]
                   #:final (not (set-member? used-colors smallest-color)))
          smallest-color))
      (color-set! u smallest-color)
      (when (equal? smallest-color (unbox color-box))
        (set-box! color-box (add1 (unbox color-box)))))
    (values (unbox color-box) (color->hash))))

(define (order-smallest-last graph)
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
#lang racket
(require (for-syntax racket/base racket/syntax syntax/parse 
                     syntax/parse/experimental/template))



(require racket/generic)
(provide (all-defined-out)) ; not enough to only provide gen:graph
;; generic graph interface
(define-generics graph
  (has-vertex? graph v)
  (has-edge? graph u v)
  (vertex=? graph u v)
  (add-edge! graph u v [weight])
  (add-directed-edge! graph u v [weight])
  (remove-edge! graph u v)
  (remove-directed-edge! graph u v)
  (add-vertex! graph v)
  (remove-vertex! graph v)
  (rename-vertex! graph u v)
  (get-vertices graph)
  (in-vertices graph)
  (get-neighbors graph v)
  (in-neighbors graph v)
  (get-edges graph)
  (in-edges graph)
  (edge-weight graph u v #:default [default])
  (transpose graph)
  (graph-copy graph)
  (graph-union! graph other))
         
(define (coloring/greedy G)
  (define num-colors 0)
  (define-vertex-property G color)
  (define vs (get-vertices G))
  (define ordered-vs (smallest-last G))
  (define num-vs (length vs)) 
  (for ([u ordered-vs])
    (define used-colors 
      (for/set ([v (in-neighbors G u)]) (color v #:default num-vs)))

    (define smallest-color
      (for/last ([smallest-color (in-range num-vs)]
                 #:final (not (set-member? used-colors smallest-color)))
        smallest-color))
    (color-set! u smallest-color)
    (when (= smallest-color num-colors) (add1 num-colors)))
  (values num-colors (color->hash)))


(define (smallest-last G)
  (define-vertex-property G deg 
    #:init (length (get-neighbors G $v)))
  (define H (r:make-heap (λ (x y) (< (deg x) (deg y)))))
  (r:heap-add-all! H (get-vertices G))
  (define in-H (apply set (get-vertices G)))
  (let loop ([res null])
    (cond 
      [(set-empty? in-H) res]
      [else
       ;; keep popping until we find min that is "in H"
       (let remove-loop ()
         (unless (set-member? in-H (r:heap-min H)) 
           (r:heap-remove-min! H) (remove-loop)))
       (define min-v (r:heap-min H))
       (r:heap-remove-min! H)
       (set! in-H (set-remove in-H min-v))
       ;; subtract degrees from neighbors of min-v
       (for ([v (in-neighbors G min-v)]) 
         (deg-set! v (sub1 (deg v)))
         (r:heap-add! H v))
       (loop (cons min-v res))])))

(define-syntax (define-vertex-property stx)
  (syntax-parse stx
    [(_ g prop (~or (~optional (~seq #:init init-expr:expr))
                    (~optional (~seq #:vs vs))) ...)
     #:with hash-name (generate-temporary #'prop)
     #:with prop-set! (format-id #'prop "~a-set!" #'prop)
     #:with prop->hash (format-id #'prop "~a->hash" #'prop)
     #:with prop-defined? (format-id #'prop "~a-defined?" #'prop)
     #:with prop-count (format-id #'prop "~a-count" #'prop)
     (template
      (begin
        (define hash-name (make-hash))
        (define (prop key #:default 
                      [fail (λ () (error 'prop "no ~a value for ~a" 'prop key))])
          (hash-ref hash-name key fail))
        (define (prop->hash) hash-name)
        (define (prop-set! key val) (hash-set! hash-name key val))
        (define (prop-defined? key) (hash-has-key? hash-name key))
        (define (prop-count) (hash-count hash-name))
        (?? (for ([v (?? vs (in-vertices g))])
              (prop-set! v 
                (syntax-parameterize ([$v (syntax-id-rules () [_ v])])
                  init-expr))))))]))

(struct unweighted-graph (adjlist) 
   #:methods gen:equal+hash
  [(define (equal-proc g1 g2 equal?-recur) 
     (equal?-recur (get-adjlist g1) (get-adjlist g2)))
   (define (hash-proc g hash-recur) (* 3 (hash-recur (get-adjlist g))))
   (define (hash2-proc g hash2-recur) (* 4 (hash2-recur (get-adjlist g))))]
  #:methods gen:graph
  [(define (get-vertices g) (get-unweighted-graph-vertices g))
   (define (in-vertices g) (in-unweighted-graph-vertices g))
   (define (get-neighbors g v) (sequence->list (in-unweighted-graph-neighbors g v)))
   (define (in-neighbors g v) (in-unweighted-graph-neighbors g v))
   (define (vertex=? g u v) (equal? u v))  
   (define (add-edge! g u v [weight #f])
     (define adj (get-adjlist g))
     (add-edge@ adj u v)
     (add-edge@ adj v u))
   (define (remove-edge! g u v)
     (define adj (get-adjlist g))
     (remove-edge@ adj u v)
     (remove-edge@ adj v u))
   (define (add-vertex! g v) (add-vertex@ (get-adjlist g) v))
   (define (remove-vertex! g v) (remove-vertex@ (get-adjlist g) v))
   (define (rename-vertex! g old new)
     (when (member new (get-vertices g))
       (error 'rename-vertex! "new vertex ~a already exists in the graph" new))
     (rename-vertex@ (get-adjlist g) old new))
   (define (has-vertex? g v) (and (member v (get-vertices g)) #t))
   (define (has-edge? g u v)
     (and (has-vertex? g u) (has-vertex? g v)
          (member v (get-neighbors g u))
          #t))
   ;; returns edges as a sequence
   (define (in-edges g) (in-list (get-edges g)))
   (define (get-edges g) 
     (for*/list ([u (in-vertices g)] [v (in-neighbors g u)]) (list u v)))
   (define (graph-copy g)
     (struct-copy unweighted-graph g [adjlist (hash-copy (get-adjlist g))]))
   ])

(define (mk-unweighted-graph/undirected es)
  (define adj (make-hash))
  (for ([e es])
    (cond [(list? e)
           (unless (= (length e) 2)
             (raise-argument-error 'undirected-graph "edge, as length 2 list" e))
           (apply add-edge@ adj e)
           (apply add-edge@ adj (reverse e))]
          [else (add-vertex@ adj e)])) ; neighborless vertices
  (unweighted-graph adj))

(define (get-unweighted-graph-vertices g) (hash-keys (get-adjlist g)))
(define-syntax-rule (get-adjlist g) (unsafe-struct*-ref g 0))

(define (add-edge@ adj u v) (hash-update! adj u (λ (vs) (set-add vs v)) (set)))






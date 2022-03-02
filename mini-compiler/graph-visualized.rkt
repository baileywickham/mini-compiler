#lang racket

(provide display-graph)

(require graph)
(require racket/gui/base)

(define (display-graph g colors)
  (define bitmap (graph->image g colors))
  (display-img bitmap))

;;
(define (graph->image g colors)
  (let-values ([(dot-in viz-out) (make-pipe)]
               [(png-in dot-out) (make-pipe)])
    (graphviz g #:output viz-out #:colors colors)
    (close-output-port viz-out)

    (parameterize ([current-input-port dot-in] [current-output-port dot-out])
      (system "dot -Tpng"))
    (close-output-port dot-out)

    (read-bitmap png-in)))


(define (display-img img)
  (define f (new frame% [label "Control Flow Graph"] [width 100] [height 100]))
  (new message% [parent f] [label img])
  (send f show #t))

#lang racket

(provide visualize-cfg)

(require graph)
(require racket/gui/base)
(require "util.rkt" "ast.rkt")

(define+ (visualize-cfg (Mini types decs funs))
  (define edge-info (make-hash '()))
  (define block-info (make-hash '()))
  
  (define m (append-map (λ (f) (graph-fun f edge-info block-info)) funs))
  (define g (unweighted-graph/directed m))

  (define-vertex-property g code #:init (hash-ref block-info $v))
  
  (define bitmap (graph->image g code))
  (display-img bitmap))

;;
(define+ (graph-fun (Fun id _ _ _ body) edge-info block-info)
  (append-map (λ (b) (graph-block b edge-info block-info)) body))

;;
(define+ (graph-block (and b (Block* id stmts)) edge-info block-info)
  (hash-set! block-info id (format-block b))
  (match (last stmts)
    [(Goto* label) (list (list id label))]
    [(GotoCond* _ iftrue iffalse) (list (list id iftrue) (list id iffalse))]
    [_ '()]))

(define+ (format-block (Block* id stmts))
  (string-join
   (map (λ (v) (pretty-format (~dbg v) 40 #:mode 'display))
        (cons id stmts)) "\n"))

(define (~dbg stmt)
  (match stmt
    [(Prim op exps) `(,op ,@(map ~dbg exps))]
    [(Dot left id) `(,(~dbg left) . ,id)]
    [(Inv id args) `(,id ,@(map ~dbg args))]
    [(Assign target source) `(,(~dbg target) = ,(~dbg source))]
    [(GotoCond* cond iftrue iffalse) `(goto ,(~dbg cond) ,iftrue ,iffalse)]
    [(Null) 'null]
    [(Read) '(read)]
    [(Print exp endl) `(print ,(~dbg exp) ,endl)]
    [(New id) `(new ,id)]
    [(Goto* l) `(goto ,l)]
    [(Return exp) `(return ,(~dbg exp))]
    [_ stmt]))

;;
(define (graph->image g code)
  (let-values ([(dot-in viz-out) (make-pipe)]
               [(png-in dot-out) (make-pipe)])
    (graphviz g #:output viz-out
              #:vertex-attributes
              (list (list 'label code)
                    (list 'shape (thunk* "box"))
                    (list 'fontname (thunk* "consolas"))
                    (list 'fontsize (thunk* "12pt"))
                    #;(list 'nojustify (thunk* "true"))
                    (list 'labeljust (thunk* "l"))))
    (close-output-port viz-out)
    
    (parameterize ([current-input-port dot-in] [current-output-port dot-out])
      (system "dot -Tpng"))
    (close-output-port dot-out)
    
    (read-bitmap png-in)))


(define (display-img img)
  (define f (new frame% [label "Control Flow Graph"] [width 100] [height 100]))
  (new message% [parent f] [label img])
  (send f show #t))

hash-ref!
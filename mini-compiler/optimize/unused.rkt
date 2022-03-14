#lang racket

(provide remove-unused)

(require "common.rkt")

;;
(define+ (remove-unused (LLVM tys decs funs))
  (LLVM tys decs (map remove-unused/fun funs)))

;;
(define+ (remove-unused/fun (FunLL id params ret-ty body))
  (FunLL id params ret-ty (remove-unused/body body (map car params))))

;;
(define (remove-unused/body blocks params)
  (define unused (set-subtract
                  (set-subtract (all-writes blocks) (all-reads blocks))
                  params))
  (if (empty? unused)
      blocks
      (remove-unused/body ((remove-stmts* unused) blocks) params)))

;;
(define (remove-stmts* unused)

  ;;
  (define (remove-stmts/blocks blocks)
    (map remove-stmts/block blocks))

  ;;
  (define+ (remove-stmts/block (Block id stmts))
    (Block id (filter-map remove-stmts/stmt stmts)))

  ;;
  (define (remove-stmts/stmt stmt)
    (match stmt
      [(AssignLL (? unused?) (? CallLL? call)) call]
      [(AssignLL (? unused?) _) #f]
      [(PhiLL (? unused?) _ _) #f]
      [_ stmt]))

  ;;
  (define (unused? v)
    (member v unused))

  remove-stmts/blocks)

;;
(define (all-writes blocks)
  (filter ssa-reg? (get-all stmt-writes blocks)))

;;
(define (all-reads blocks)
  (filter ssa-reg? (get-all stmt-reads blocks)))
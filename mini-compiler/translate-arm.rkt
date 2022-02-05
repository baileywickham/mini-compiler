#lang racket

(provide translate-arm)

(require "ast.rkt" "util.rkt" "symbol.rkt")

(define easy-ops
  #hash((add . add)
        (sub . sub)
        (and . and)
        (or . orr)
        (xor . eor)))

(define comp-ops
  #hash((sle . le)
        (sgt . gt)
        (sge . ge)
        (slt . lt)
        (eq . eq)
        (ne . ne)))

(define arg-regs (list (RegA 'r0) (RegA 'r1) (RegA 'r2) (RegA 'r3)))


(define+ (translate-arm (LLVM _ decs funs))
  (ARM (map translate-dec decs)
       (map translate-fun funs)))

(define+ (translate-dec (GlobalLL (IdLL id _) _ _))
  (CommA id))

(define+ (translate-fun (FunLL (IdLL id _) params _ body))
  (define header (make-fun-header params))
  (define blocks (map translate-block ((remove-phis*) body)))
  (FunA id (list-update blocks 0 (curry extend-block header))))

(define (make-fun-header params)
  (append (list (PushA (list (RegA 'fp ) (RegA 'lr)))
                (OpA 'add (RegA 'fp) (RegA 'sp) 4))
          (map move-parameter
               params (build-list (length params) identity))))

(define+  (move-parameter (cons param _) index)
  (if (< index (length arg-regs))
      (MovA #f param (list-ref arg-regs index))
      (LdrA param (OffsetA (RegA 'sp) (* 4 (- index (length arg-regs)))))))

(define (remove-phis*)
  (define phi-moves (make-hash))

  (define (remove-phis blocks)
    (map add-mvs-block (map remove-phis-block blocks)))

  (define+ (remove-phis-block (BlockLL id stmts))
    (BlockLL id (map remove-phis-stmt stmts)))

  (define (remove-phis-stmt stmt)
    (match stmt
      [(PhiLL id _ args)
       (let ([phi-id (IdLL (make-label '_phi) #f)])
         (for ([arg args])
           (match-let ([(cons block-id (cons id _)) arg])
             (add-phi-move! block-id (AssignLL phi-id id))))
         (AssignLL id phi-id))]
      [_ stmt]))

  (define (add-phi-move! block-id move)
    (hash-set! phi-moves block-id (cons move (hash-ref phi-moves block-id '()))))

  (define+ (add-mvs-block (BlockLL id stmts))
    (BlockLL id (let-values ([(before after) (split-at-right stmts 1)])
                  (append before (hash-ref phi-moves id '()) after))))

  remove-phis)

(define+ (translate-block (BlockLL id stmts))
  (BlockA (LabelA id) (append-map translate-stmt stmts)))

(define (translate-stmt stmt)
  (match stmt
    [(BrLL (IdLL id _))
     (list (BrA #f (LabelA id)))]
    [(BrCondLL cond (IdLL iftrue _) (IdLL iffalse _))
     (list (CmpA cond 1)
           (BrA 'eq (LabelA iftrue))
           (BrA #f (LabelA iffalse)))]
    [(AssignLL target (? IdLL? src))
     (list (MovA #f target src))]
    [(AssignLL target (BinaryLL (? easy-op? op) _ arg1 arg2))
     (list (OpA (hash-ref easy-ops op) target arg1 arg2))]
    [(AssignLL target (BinaryLL 'mul _ arg1 arg2))
     (list (OpA 'mul target arg1 arg2))]
    [(AssignLL target (GetEltLL _ ptr 0))
     (list (MovA #f target ptr))]
    [(AssignLL target (GetEltLL _ ptr index))
     (list (OpA 'add target ptr (* index (/ int-size byte-size))))]
    [(AssignLL target (CastLL op _ val _))
     (list (MovA #f target val))]
    [(AssignLL target (BinaryLL 'sdiv _ arg1 arg2))
     (translate-stmt (AssignLL target (CallLL #f (IdLL '__aeabi_idiv #t)
                                              (list (cons arg1 int) (cons arg2 int)) #f)))]
    [(StoreLL _ val ptr)
     (list (StrA val ptr))]
    [(AssignLL target (BinaryLL (? comp-op? op) _ arg1 arg2))
     (list (MovA #f target 0)
           (CmpA arg1 arg2)
           (MovA (hash-ref comp-ops op) target 1))]
    [(AssignLL target (? CallLL? c))
     (append (translate-call c)
             (list (MovA #f target (RegA 'r0))))]
    [(? CallLL? c) (translate-call c)]
    [(AssignLL target (LoadLL _ ptr))
     (list (LdrA target ptr))]
    [(ReturnLL _ (? void?))
     (list (PopA (list (RegA 'fp) (RegA 'pc))))]
    [(ReturnLL _ arg)
     (list (MovA #f (RegA 'r0) arg)
           (PopA (list (RegA 'fp) (RegA 'pc))))]
    [o (list o)]))

(define+ (translate-call (CallLL _ (IdLL fn _) args _))
  (define new-args (map store-arg args (build-list (length args) identity)))
  (append new-args (list (BrA 'l fn))))

(define+ (store-arg (cons arg _) i)
  (if (<= i (length arg-regs))
      (MovA #f (list-ref arg-regs i) arg)
      (PushA (list arg))))

(define+ (extend-block stmts (BlockA id block-stmts))
  (BlockA id (append stmts block-stmts)))

(define (comp-op? op)
  (hash-has-key? comp-ops op))

(define (easy-op? op)
  (hash-has-key? easy-ops op))

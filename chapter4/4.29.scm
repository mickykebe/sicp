(define (identity x) x)

(define y (identity 5))
;Here y is a thunk. '(thunk 5 global-env)

;Now if we have a procedure or a sequence continually accessing y, with memoization the expression in the thunk -- 5 -- is computed only once. Without memoization the expression 5 would be evaluated inside global-env every time it's accessed. Instead of 5 if the expression inside the thunk was more computationally intensive the effect would be an increase in computational inefficiency.

(define (id x)
  (set! count (+ count 1))
  x)
(define (square x)
  (* x x))

;With memoization:
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100
;;; L-Eval input:
count
;;; L-Eval value:
1

;Without memoization:
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100
;;; L-Eval input:
count
;;; L-Eval value:
2

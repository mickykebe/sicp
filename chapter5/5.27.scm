(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

;(factorial 2)
;(total-pushes = 48 maximum-depth = 13)
;(factorial 3)
;(total-pushes = 80 maximum-depth = 18)
;(factorial 4)
;(total-pushes = 112 maximum-depth = 23)
;(factorial 5)
;(total-pushes = 144 maximum-depth = 28)

;               Maximum depth   Number of pushes

;   Recursive   5n+3            32n - 16
;   factorial

;   Iterative   10              35n + 29
;   factorial

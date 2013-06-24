(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;(fib 2)
;(total-pushes = 72 maximum-depth = 13)
;1
;(fib 3)
;(total-pushes = 128 maximum-depth = 18)
;2
;(fib 4)
;(total-pushes = 240 maximum-depth = 23)
;3
;(fib 5)
;(total-pushes = 408 maximum-depth = 28)
;5

;a)
;max-depth: 5n + 3

;b)
;S(n) = S(n-1) + S(n-2) + k
;when n = 4
;S(4) = S(3) + S(2) + k
;240 = 128 + 72 + k
;240 = 200 + k
;k = 40

;S(n) = a*Fib(n+1) + b
;n = 2
;S(2) = aFib(3) + b
;72 = 2a + b

;n = 3
;S(3) = aFib(4) + b
;128 = 3a + b

; ( 2a + b = 72 ) * -1
;   3a + b = 128

; [ -2a -b = -72 ]  +
; [ 3a + b = 128 ]

;   a = 128-72
;   a = 56

;   112 + b = 72
;   b = -40

;To test this:

;S(4) = 56Fib(5) - 40
;S(4) = 56*5 - 40
;S(4) = 240

;Success!!!

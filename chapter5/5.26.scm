(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

;(factorial 2)
;(total-pushes = 99 maximum-depth = 10)
;(factorial 3)
;(total-pushes = 134 maximum-depth = 10)
;(factorial 4)
;(total-pushes = 169 maximum-depth = 10)
;(factorial 5)
;(total-pushes = 204 maximum-depth = 10)

;a)
;Maximum-depth = 10

;b) 29 + 35*n

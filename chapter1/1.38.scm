(cont-frac (lambda (i) 1) (lambda (i) (if (= (remainder i 3) 2) (* (/ 2.0 3) (+ i 1)) 1)) 2)

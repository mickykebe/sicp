(define (pascal x y)
    (cond ((= x 0) 1)
          ((= y 0) 1)
          (else (+ (pascal (- x 1) y) (pascal x (- y 1))))))

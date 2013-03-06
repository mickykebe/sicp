;; 1.7
(define (sqrt x)
    (define (improve-guess guess) 
        (average guess (/ x guess)))
    (define (is-good-enough guess) 
        (< (/ (abs (- guess (improve-guess guess))) guess) 0.001))
    (define (sqrt-iter guess) 
        (if (is-good-enough guess) 
            guess 
            (sqrt-iter (improve-guess guess))))
    (sqrt-iter 1.0))


;;1.8
(define (cuberoot x)
    (define (improve-guess guess) 
        (/ (+ (/ x (square guess)) (* 2 guess)) 3))
    (define (is-good-enough guess) 
        (< (/ (abs (- guess (improve-guess guess))) guess) 0.001))
    (define (cuberoot-iter guess) 
        (if (is-good-enough guess) 
            guess 
            (cuberoot-iter (improve-guess guess))))
    (cuberoot-iter 1.0))

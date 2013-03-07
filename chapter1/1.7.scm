(define (sqrt x) (sqrt-iter 1.0 x))

(define (sqrt-iter guess x) (if (is-good-enough guess x) guess (sqrt-iter (improve-guess guess x) x)))

(define (improve-guess guess x) (average guess (/ x guess)))

(define (is-good-enough guess x) (< (/ (abs (- guess (improve-guess guess x))) guess) 0.001))

(define (average x y) (/ (+ x y) 2))

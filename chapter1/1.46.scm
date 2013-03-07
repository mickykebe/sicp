;a)
(define (compose f g)
    (lambda (x) (f (g x))))

(define (iterative-improvement good-enough? improve)
    (lambda (guess)
        (if (good-enough? guess)
            guess
            ((iterative-improvement good-enough? improve) (improve guess)))))

;b)
(define (sqrt x)
    (define (improve guess) 
        (average guess (/ x guess)))
    (define (good-enough? guess) 
        (< (abs (- x (square guess))) 0.001))
    ((iterative-improvement good-enough? improve) 1.0))

;c)

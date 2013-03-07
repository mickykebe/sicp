(define tolerance 0.00001)
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
             (if (close-enough? guess next)
                guess
                (try next))))
    (try first-guess))

(define (sqrt x)
    (fixed-point (lambda (y) (average (/ x y) y)) 1.0))

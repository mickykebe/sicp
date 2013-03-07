(define tolerance 0.00001)
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
             (display guess)
             (newline)
             (if (close-enough? guess next)
                guess
                (try next))))
    (try first-guess))

(define (x)
    (fixed-point (lambda (n) (/ (log 1000) (log n))) 2.0))

(define (x)
    (fixed-point (lambda (n) (/ (+ (/ (log 1000) (log n)) n) 2)) 2.0))

;(steps without) 34 (steps with) 9

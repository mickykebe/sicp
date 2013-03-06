; Fixed-point
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

; Derivative method
(define dx 0.00001)
(define (deriv g)
    (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

;Newton's method
(define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (cube x)
    (* x x x))

;Answer
(define (cubic a b c)
    (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

;E.g.
;(newtons-method (cubic 3 3 3) 1)

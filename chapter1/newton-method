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

(define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x)) 1.0))

;further abstraction
(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))

;newton's sqrt can be expressed as
(define (sqrt x)
    (fixed-point-of-transform (lambda (y) (- (square y) x)) 
                              newton-transform 
                              1.0))

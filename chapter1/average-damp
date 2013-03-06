(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (sqrt x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

;further abstraction
(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))

(define (sqrt x)
    (fixed-point-of-transform (lambda (y) (/ x y))
                              average-damp
                              1.0))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (sqrt x) 
    (fixed-point ((repeated (average-damp 1)) (lambda (y) (/ x y))) 1.0))

(define (cube-root x) 
    (fixed-point ((repeated average-damp 1) (lambda (y) (/ x (fast-exp y 2)))) 1.0))

(define (fourth-root x) 
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (fast-exp y 3)))) 1.0))

(define (fifth-root x) 
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (fast-exp y 4)))) 1.0))

(define (sixth-root x) 
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (fast-exp y 5)))) 1.0))

(define (seventh-root x) 
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (fast-exp y 6)))) 1.0))

(define (eighth-root x) 
    (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (fast-exp y 7)))) 1.0))

;Answer(sort of)
(define (nth-root x)
    (fixed-point ((repeated average-damp [log x base 2]) (lambda (y) (/ x (fast-exp y (- x 1))))) 1.0))


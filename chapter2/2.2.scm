;Point constructor and selectors
(define (make-point x y)
    (cons x y))

(define (x-point pt)
    (car pt))

(define (y-point pt)
    (cdr pt))

(define (print-pt p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

;Segment constructor and selectors
(define (make-segment x-pt y-pt)
    (cons x-pt y-pt))

(define (start-segment segment)
    (car segment))

(define (end-segment segment)
    (cdr segment))

(define (midpoint-segment segment)
    (make-point (average 
                    (x-point (start-segment segment)) (x-point (end-segment segment)))
                (average 
                    (y-point (start-segment segment)) (y-point (end-segment segment)))))

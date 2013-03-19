(define (make-segment v1 v2)
    (cons v1 v2))

(define (start-segment s)
    (car s))

(define (end-segment s)
    (cdr s))

make-segment and selectors start-segment and end-segment.

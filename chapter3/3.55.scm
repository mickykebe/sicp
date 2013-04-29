(define (partial-sums s)
    (define x (cons-stream (stream-car s) (add-streams (stream-cdr s) x)))
    x)

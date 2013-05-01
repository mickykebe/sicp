(define (neg-series s)
    (stream-map (lambda (x) (- x)) s))

(define (invert-unit-series s)
    (cons-stream 1 (neg-series (mul-series (stream-cdr s) (invert-unit-series s)))))

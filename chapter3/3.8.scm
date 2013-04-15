;We can model our function based on one result set
;((f 0), (f 1)) -> (0, 0)
;((f 1), (f 0)) -> (1, 0)

;The following function gives us that
(define (f n)
    (define x 1)
    (if (= n 0)
        (begin (set! x 0) x)
        x))

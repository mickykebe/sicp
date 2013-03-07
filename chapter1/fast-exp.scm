(define (fast-exp b n)
    (cond ((= n 0) 1)
           ((even? n) (fast-exp (square b) (/ n 2)))
           (else (* b (fast-exp b (- n 1))))))

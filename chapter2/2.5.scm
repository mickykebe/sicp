(define (cons a b)
    (* (fast-exp 2 a) (fast-exp 3 b)))

(define (car z)
    (if ((divisible?) z 3)
        (car (/ z 3))
        ((logB) z 2)))

(define (cdr z)
    (if ((divisible?) z 2)
        (cdr (/ z 2))
        ((logB) z 3)))

(define (divisible?)
    (lambda (x y) (= (remainder x y) 0)))

(define (logB)
    (lambda (x b) (/ (log x) (log b))))

(define (fast-exp b n)
    (cond ((= n 0) 1)
           ((even? n) (fast-exp (square b) (/ n 2)))
           (else (* b (fast-exp b (- n 1))))))

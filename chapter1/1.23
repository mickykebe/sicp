(define (prime? n)
   (= n (smallest-divisor n)))

(define (smallest-divisor n)
    (first-divisor n 2))

(define (first-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (first-divisor n (next test-divisor)))))

(define (next test-divisor)
    (if (= test-divisor 2) 3 (+ test-divisor 2)))

(define (divides? a b)
    (= (remainder b a) 0))

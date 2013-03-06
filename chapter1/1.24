(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (random n)))

(define (fast-prime n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime n (- times 1)))
          (else false)))

(define (prime? n)
    (fast-prime n 100))

(define (report-prime n elapsed-time)
    (newline)
    (display n)
    (display " *** ")
    (display elapsed-time))

(define (start-prime-test n start-time)
    (if (prime? n)
      (report-prime n (- (runtime) start-time))))

(define (timed-prime-test n)
    (start-prime-test n (runtime)))

; log(1000) + **log(1000000/1000)** = log(1000000)

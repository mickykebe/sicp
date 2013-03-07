(define (timed-prime-test n)
    (start-prime-test n (runtime)))
    
(define (start-prime-test n start-time)
    (if (prime? n)
      (report-prime n (- (runtime) start-time))))
      
(define (report-prime n elapsed-time)
    (newline)
    (display n)
    (display " *** ")
    (display elapsed-time))

(define (search-for-primes start end)
    (if (even? start) (search-odd-primes (+ start 1) end) (search-odd-primes start end)))

(define (search-odd-primes start end)
    (cond ((< start end) 
        (timed-prime-test start) 
        (search-odd-primes (+ start 2) end))))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (prime? n)
    (define (fermat-prime? a)
        (= (expmod a n n) a))
    (define (fermat-iter a)
        (cond ((< a n) (if (fermat-prime? a) (fermat-iter (+ a 1)) false))
              (else true)))
    (fermat-iter 1))


; 561, 1105, 1729, 2465, 2821, and 6601

(define (filtered-accumulate filter combiner null-value term a next b)
    (if (or (> a b))
        null-value
        (combiner 
            (if (filter a) 
                (term a) 
                null-value) 
            (filtered-accumulate filter combiner null-value term (next a) next b))))

;a
(define (sum-squared-primes from to)
    (filtered-accumulate prime? + 0 square from inc to))

;b
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (prod-rel-primes n)
    (define (filter i)
        (= (gcd i n) 1))
    (filtered-accumulate filter * 1 identity 1 inc n))



(define (inc n)
    (+ n 1))

;prime
(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp) (non-triv (expmod base (/ exp 2) m) m))
          (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (non-triv a n)
    (cond ((and (not (or (= a 1) (= a (- n 1)))) (= (remainder (square a) n) 1)) 0)
          (else (remainder (square a) n))))

(define (prime? n)
    (define (miller-rabin-prime? a)
        (= (expmod a (- n 1) n) 1))
    (define (miller-rabin-iter a)
        (cond ((< a n) (if (miller-rabin-prime? a) (miller-rabin-iter (+ a 1)) false))
              (else true)))
    (miller-rabin-iter 1))

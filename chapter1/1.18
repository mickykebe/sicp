(define (* a b)
    (*-iter a b 0))

(define (*-iter a b prod)
    (cond ((= b 0) prod)
          ((even? b) (*-iter (double a) (halve b) prod))
          (else (*-iter a (- b 1) (+ prod a)))))

(define (even? n)
    (= (remainder n 2) 0))

(define (double n)
    (+ n n))

(define (halve n)
    (/ n 2))

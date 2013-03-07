(define (product term a next b)
    (if (> a b)
        1
        (* (term a) (product term (next a) next b))))

(define (inc n) (+ n 1))

(define (identity n) n)

(define (factorial n)
    (product identity 1 inc n))

;John Wallis Pi
(define (pi n)
    (define (f k)
        (* (/ (* 2 k) (- (* 2 k) 1)) (/ (* 2 k) (+ (* 2 k) 1))))
    (* 2.0 (product f 1 inc n)))

(define (prod-iter term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* (term a) result))))
    (iter (term a) 1))

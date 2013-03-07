(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

;simpson's integral
(define (simp-integral f a b n)
    (define (h)
        (/ (- b a) n))
    (define (y-of k)
        (f (+ a (* k (h)))))
    (define (term k)
        (* (y-of k)
            (cond ((or (= k 0) (= k n)) 1)
                ((even? k)  2.0)
                (else 4.0))))
    (define (inc n)
        (+ n 1))
    (* (/ (h) 3) (sum term 0 inc n)))

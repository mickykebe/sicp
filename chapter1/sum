(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

(define (inc n)
    (+ n 1))

(define (cube n) (* n n n))

(define (sum-cubes a b)
    (sum cube a inc b))

(define (identity x) x)

(define (sum-integers start end)
    (sum identity start inc end))

;pi-sum
(define (pi-sum-term n)
    (/ 1.0 (* n (+ n 2))))

(define (pi-sum-inc n)
    (+ n 4))

(define (pi-sum start end)
    (sum pi-sum-term start pi-sum-inc end))

;integral
(define (integral f a b dx)
    (define (add-dx n)
        (+ n dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

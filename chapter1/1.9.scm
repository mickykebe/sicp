(define (+ a b)
    (if (= a 0)
        b
        (inc (+ (dec a) b))))

(+ 3 4)

(inc (+ (dec 3) 4))
(inc (+ 2 4))
(inc 6)
7

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

(+ 3 4)
(+ (dec 3) (inc 4))
(+ 2 5)
7

Iterative

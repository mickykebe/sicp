;Improve make-rat to handle negatives
(define (neg? x)
    (< x 0))

(define (make-rat n d)
    (let ((g (gcd n d)))
        (let ((numer (/ n g))
              (denom (/ d g)))
              (if (neg? denom)
                (cons (* numer -1) (* denom -1))
                (cons numer denom)))))

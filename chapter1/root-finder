(define (average a b) (/ (+ a b) 2))

(define (positive? a) (> a 0))

(define (negative? a) (< a 0))

(define (close-enough? a b)
    (< (abs (- a b)) 0.001))

(define (search f neg-pt pos-pt)
    (let ((mid-point (average neg-pt pos-pt)))
        (if (close-enough? neg-pt pos-pt)
            mid-point
            (let ((test-value (f mid-point)))
                (cond ((positive? test-value) (search f neg-pt mid-point))
                      ((negative? test-value) (search f mid-point pos-pt))
                      (else mid-point))))))

(define (half-interval f a b)
    (let ((a-value (f a))
          (b-value (f b)))
            (cond ((and (negative? a-value) (positive? b-value)) (search f a b))
                  ((and (negative? b-value) (positive? a-value)) (search f b a))
                  (else (error "Values are not of opposite sign" a b)))))

;a
(define (pseudoremainder-terms L1 L2)
    (let ((int-factor (list (make-term 0 
                                       (- (order (first-term L1)) 
                                          (order (first-term L2)))))))
        (cadr (div-terms (mul-terms int-factor L1) L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (rm-common-factors (gcd-terms b (pseudoremainder-terms a b)))))

;b
(define (rm-common-factors terms)
    (define (common-factor terms)
        (if (null? (rest-terms terms))
            (coeff (first-term terms))
            (gcd (coeff (first-term terms)) (common-factor (rest-terms terms)))))
    (let ((cf (common-factor terms)))
        (map (lambda (term) (make-term (order term) 
                                       (/ (coeff term) cf)))
             terms)))

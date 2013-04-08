(define (pseudoremainder-terms L1 L2)
    (let ((int-factor (list (make-term 0 
                                       (exp (coeff L2)
                                            (+ 1
                                               (- (order (first-term L1)) 
                                                  (order (first-term L2)))))))))
        (cadr (div-terms (mul-terms int-factor L1) L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (rm-common-factors (gcd-terms b (pseudoremainder-terms a b)))))

(define (rm-common-factors terms)
    (define (common-factor terms)
        (if (null? (rest-terms terms))
            (coeff (first-term terms))
            (gcd (coeff (first-term terms)) (common-factor (rest-terms terms)))))
    (let ((cf (common-factor terms)))
        (map (lambda (term) (make-term (order term) 
                                       (/ (coeff term) cf)))
             terms)))

;a
(define (reduce-terms n d)
    (let ((g (gcd-terms n d)))
        (let ((c (list (make-term 0 
                                  (exp (coeff (first-term g))
                                       (+ 1
                                          (- (max (order (first-term n))
                                                  (order (first-term d)))
                                             (order (first-term g)))))))))
            (let ((n-with-c (mul-terms n c))
                  (d-with-c (mul-terms d c)))
                (list (rm-common-factors n-with-c) (rm-common-factors n-with-d))))))

(define (reduce-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1) 
                   (reduce-terms (term-list p1)
                                 (term-list p2)))
        (error "Polys not in same var -- REDUCE-POLY")))

;b
;Inside scheme-number package
(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))

(put 'reduce '(scheme-number scheme-number)
     (lambda (x y)
        (let ((reduced (reduce-integers x y)))
            (list (tag (car reduced))
                  (tag (cadr reduced))))))

;Inside polynomial package
(put 'reduce '(polynomial polynomial)
     (lambda (x y)
        (let ((reduced (reduce-poly x y)))
            (list (tag (car reduced))
                  (tag (cadr reduced))))))

;Generic reduce
(define (reduce n d)
    (apply-generic 'reduce n d))
            

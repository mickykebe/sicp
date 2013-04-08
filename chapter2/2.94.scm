;Inside polynomial package
(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (remainder-terms L1 L2)
    (cadr (div-terms L1 L2)))

(define (gcd-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (gcd-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- GCD-POLY")))

(put 'greatest-common-divisor '(polynomial polynomial)
     (lambda (p1 p2) (tag (gcd-poly p1 p2))))

;Inside scheme-number package
(put 'greatest-common-divisor '(scheme-number scheme-number)
     (lambda (x y) (tag (gcd x y))))

;Generic operation
(define (greatest-common-divisor x y)
    (apply-generic 'greatest-common-divisor x y))

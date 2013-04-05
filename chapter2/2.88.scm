(define (negate x)
    (apply-generic 'negate x))

(define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (add-poly p1 (negate p2))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

(put 'sub '(polynomial polynomial)
     (lambda (p1 p2) (tag (sub-poly p1 p2))))

; negate in the various packages

; polynomial-package
 
(define (negate-poly p)
    (make-poly (variable p) (negate-terms (term-list p))))

(define (negate-terms L)
    (if (empty-termlist? L)
        L
        (let ((t1 (first-term L)))
            (adjoin-term (negate-term t1)
                         (next-terms (rest-terms L))))))

(define (negate-term term)
    (make-term (order term)
               (negate (coeff term))))

(put 'negate '(polynomial) 
     (lambda (x) (tag (negate-poly x))))

; scheme-number package

(define (negate num)
    (* num -1))

(put 'negate '(scheme-number) 
     (lambda (x) (tag (negate x))))

; rational package
(define (negate num)
    (make-rat (* (numer num) -1) (denom num))))

(put 'negate '(rational) 
     (lambda (x) (tag (negate x))))

; complex package
(define (negate-complex num)
    (make-from-real-imag (negate (real-part num)) (imag-part num)))

(put 'negate '(complex) 
     (lambda (x) (tag (negate-complex x))))

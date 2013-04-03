; Generic raise
(define (raise num)
    (apply-generic 'raise num))

;integer-package
(define (raise num)
    (make-rational num 1))

(put 'raise '(integer) raise)

;rational-package
(define (raise num)
    (make-real (/ (numer num) (denom num)))) ; Depends on representations of real no.s & implementation of make-real

(put 'raise '(rational) raise)

;real-package
(define (raise num)
    (make-complex-from-real-imag num 0))

(put 'raise '(real) raise)

;generic defintion
(define (equ? num1 num2)
    (apply-generic 'equ? num1 num2))

;scheme-number package
(define (equ? num1 num2)
    (= num1 num2))

(put 'equ? '(scheme-number scheme-number) equ?)

;rational-number package
(define (equ? num1 num2)
    (= (* (numer num1) (denom num2))
       (* (numer num2) (denom num1))))

(put 'equ? '(rational rational) equ?)

;complex-number package
(define (equ? num1 num2)
    (and (= (magnitude num1) (magnitude num2))
         (= (angle num1) (angle num2))))

(put 'equ? '(complex complex) equ?)

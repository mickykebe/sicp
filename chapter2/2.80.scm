(define (=zero? num)
    (apply-generic '=zero? num))

;scheme-number package
(put 'zero '(scheme-number) (lambda (num) (= num 0)))

;rational-number package
(define (=zero? num)
    (= (numer num) 0))

(put '=zero? '(rational) =zero?)

;complex-number package
(define (=zero? num)
    (= (magnitude num) 0))

(put '=zero? '(complex) =zero?)

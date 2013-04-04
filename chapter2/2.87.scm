(define (=zero? coef terms)
    (empty-term-list? terms))

(put '=zero? 'polynomial =zero?)

(define (addend s) (cadr s))

(define (augend s)
    (let ((last-elem (caddr s)))
        (if (null? (cdddr s))
            last-elem
            (make-sum last-elem (augend (cdr s))))))

(define (multiplier p) (cadr p))

(define (multiplicand p)
    (let ((last-elem (caddr p)))
        (if (null? (cdddr p))
            last-elem
            (make-product last-elem (multiplicand (cdr p))))))

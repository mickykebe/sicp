(define (make-accumulator amount)
    (lambda (inc)
        (if (number? inc)
            (begin (set! amount (+ amount inc))
                   amount)
            (error "Input must be a number --MAKE-ACCUMULATOR"))))

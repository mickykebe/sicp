(define (same-parity num . items)
    (define (same-parity-iter has-parity? items)
        (if (null? items)
            items
            (let ((cur-item (car items)))
                (append
                    (if (has-parity? cur-item) (list cur-item) (list)) 
                    (same-parity-iter has-parity? (cdr items))))))
    (let ((has-parity? (if (even? num) even? odd?)))
        (same-parity-iter has-parity? items)))

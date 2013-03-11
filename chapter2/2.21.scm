(define (square-list items)
    (if (null? items)
        items
        (cons (* (car items) (car items)) (square-list (cdr items)))))

(define (square-list items)
    (map (lambda (x) (* x x)) items))

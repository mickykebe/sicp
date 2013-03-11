(define (for-each proc items)
    (if (null? items)
        items
        (and    (proc (car items)) 
                (for-each proc (cdr items)))))

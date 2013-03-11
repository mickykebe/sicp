(define (for-each proc items)
    (if (null? items)
        items
        (begin  (proc (car items)) 
                (for-each proc (cdr items)))))

(define (deep-reverse tree)
    (if (null? tree)
        tree
        (append 
            (deep-reverse (cdr tree))
            (if (pair? (car tree))
                (list (deep-reverse (car tree)))
                (list (car tree))))))

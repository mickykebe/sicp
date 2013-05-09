(define (cond-actions clause) 
    (if (eq? (cadr clause) '=>)
        (list (caddr clause) (car clause))
        (cdr clause)))

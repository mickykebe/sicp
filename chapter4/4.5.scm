(define (cond-actions clause) 
    (if (eq? (cadr clause) '=>)
        (list (caddr clause) (cond-predicate clause))
        (cdr clause)))

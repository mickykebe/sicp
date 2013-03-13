(define (square-tree tree)
    (cond   ((null? tree) tree)
            ((not (pair? tree)) (* tree tree))
            (else (cons 
                    (square-tree (car tree)) 
                    (square-tree (cdr tree))))))

(define (square-tree tree)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (square-tree sub-tree)
                (* sub-tree sub-tree))) tree))

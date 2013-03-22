(define (equal? elems1 elems2)
    (if (and (null? elems1) (null? elems2))
        #t
        (let ((next-elem1 (car elems1))
              (next-elem2 (car elems2)))
            (cond ((and (pair? next-elem1) (pair? next-elem2)) (equal? next-elem1 next-elem2))
                  ((and (not (pair? next-elem1)) (not (pair? next-elem2)))
                        (if (eq? next-elem1 next-elem2)
                            (equal? (cdr elems1) (cdr elems2))
                            #f
                        ))
                  (else #f)))))

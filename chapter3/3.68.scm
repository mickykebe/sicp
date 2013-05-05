(define (pairs s t)
    (interleave (stream-map (lambda (x) (list (stream-car s) x))
                            t)
                (pairs (stream-cdr s) (stream-cdr t))))

;Because the call to pairs in this procedure isn't delayed, an endless loop is the result.

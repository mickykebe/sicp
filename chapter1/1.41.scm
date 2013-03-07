(define (double f)
    (lambda (x) (f (f x))))
; 21

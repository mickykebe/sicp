(define (memq item x)
    (cond ((null? x) #f)
          ((eq? item (car x)) x)
          (else (memq item (cdr x)))))

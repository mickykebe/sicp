(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (> (length args) 1) 
                   (null? (filter (lambda (tag) (not (eq? (tag) (car type-tags)))) (cdr type-tags))))
              (apply apply-generic op (bulk-raise args))
              (error "No method for these types"
                     (list op type-tags)))))))

(define (bulk-raise args)
    (define (raise-iter same-levels rest)
        (if (null? rest)
            same-levels
            (let ((same-levels-first (car same-levels))
                  (rest-first (car rest)))
                (cond ((same-level? same-levels-first rest-first) 
                        (raise-iter (append same-levels rest-first) (cdr rest)))
                      ((higher? same-levels-first rest-first) 
                        (raise-iter same-levels-first (cons (raise rest-first) (cdr rest))))
                      (else
                        (raise-iter (map raise same-levels) rest))))))
    (raise-iter (list (car args)) (cdr args)))

(define (same-level? datum1 datum2)
    (eq? (type-tag datum1) (type-tag datum2)))

(define (higher? datum1 datum2)
    (let ((datum2-raiser (get 'raise (type-tag datum2))))
        (if (null? datum2-raiser)
            false
            (let ((raised-datum (raise datum2)))
                (if (eq? (type-tag datum1) (type-tag raised-datum))
                    true
                    (higher? datum1 raised-datum))))))

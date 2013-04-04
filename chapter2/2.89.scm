(define (adjoin-term term term-list)
    (define (extend term-list new-length)
        (let ((len-diff (- new-length (length term-list))))
            (if (= len-diff 0)
                term-list
                (cons 0 (extend term-list (- new-length 1))))))

    (define (insert-term term term-list)
        (if (= (+ (order term) 1) (length term-list))
            (cons (coeff term) term-list)
            (cons (car term-list) (insert-term term (rest-terms term-list)))))

    (if (=zero? (coeff term))
        term-list
        (if (< (order term) (length term-list)))
            (insert-term term term-list)
            (insert-term term (extend term-list (+ (order term) 1))))))

(define (the-empty-termlist) '())

(define (first-term term-list) 
    (make-term (- (length term-list) 1) 
                  (car term-list)))

(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))

(define (order term) (car term))
(define (coeff term) (cadr term))

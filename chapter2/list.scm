(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))

(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

(define (map proc items)
    (if (null? items)
        items
        (cons (proc (car items)) (map proc (cdr items)))))

(define (scale-list items factor)
    (map (lambda (x) (* x factor)) items))

(define nil ())

(define (map proc items)
    (if (null? items)
        items
        (cons (proc (car items)) (map proc (cdr items)))))

(define (filter predicate sequence)
    (cond   ((null? sequence) sequence)
            ((predicate (car sequence)) (cons (car sequence) (filter predicate (cdr sequence))))
            (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
    (cond   ((null? tree) nil)
            ((not (pair? tree)) (list tree))
            (else (append   (enumerate-tree (car tree))
                            (enumerate-tree (cdr tree))))))

(define (sum-odd-squares tree)
    (accumulate + 
                0
                (map square 
                     (filter odd? 
                             (enumerate-tree tree)))))
;(define (fib n)
;    (cond ((= n 0) 0)
;          ((= n 1) 1)
;          (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (even-fibs n)
    (accumulate cons
                nil
                (filter even?
                        (map fib
                             (enumerate-interval 0 n)))))

(define (list-fib-squares n)
    (accumulate cons
                nil
                (map square
                     (map fib
                          (enumerate-interval 0 n)))))

(define (product-of-squares-of-odd-elements sequence)
    (accumulate *
                1
                (map square
                     (filter odd? sequence))))

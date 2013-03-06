(define x (cons 1 2))

(car x) ;1

(cdr x) ;2

(define y (cons 3 4))

(define z (cons x y))

(car (car z))

;a
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 '* m2))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))

(define (exponentiation? exp)
    (and (pair? exp) (eq? (cadr exp) '**)))

(define (base exp) (car exp))

(define (exponent exp) (caddr exp))

(define (make-exponentiation base exponent)
    (cond ((=number? base 0) 0)
          ((=number? exponent 0) 1)
          ((and (number? base) (number? exponent)) (exp base exponent))
          (else (list base '** exponent))))

;b
(define (sum? x)
    (and (pair? x) 
         (or (eq? (cadr x) '+)
             (and (not (null? (cdddr x)))
                  (eq? (cadddr x) '+)))))

(define (product? x)
    (and (pair? x) 
         (and (eq? (cadr x) '*)
              (or (null? (cdddr x))
                  (eq? (cadddr x) '*)))))

(define (addend s)
    (if (eq? (cadr s) '*)
        (make-product (car s) (caddr s))
        (car s)))

(define (augend s)
    (if (eq? (cadr s) '*)
        (if (null? (cdr (cdr (cdr (cdr (cdr s))))))
            (car (cdr (cdr (cdr (cdr s)))))
            (cddddr s))
        (if (null? (cdddr s))
            (caddr s)
            (cddr s))))

(define (multiplier p)
    (car p))

(define (multiplicand p)
    (if (null? (cdddr p))
        (caddr p)
        (cddr p)))

;exponentiation?, base, exponent, and make-exponentiation

(define (exp x n)
    (if (= n 0)
        1
        (* x (exp x (- n 1)))))

(define (=number? exp num)
    (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
            (let ((e (exponent exp))
                  (b (base exp)))
             (make-product (make-product 
                                e 
                                (make-exponentiation b (make-sum e -1)))
                           (deriv b var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (exponentiation? exp)
    (and (pair? exp) (eq? (car exp) '**)))

(define (base exp)
    (cadr exp))

(define (exponent exp)
    (caddr exp))

(define (make-exponentiation base exponent)
    (cond ((=number? base 0) 0)
          ((=number? exponent 0) 1)
          ((and (number? base) (number? exponent)) (exp base exponent))
          (else (list '** base exponent))))

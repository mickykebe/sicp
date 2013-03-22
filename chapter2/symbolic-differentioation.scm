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
                                (make-exponentiation b (- e 1)))
                           (deriv b var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s)
    (let ((last-elem (caddr s)))
        (if (null? (cdddr s))
            last-elem
            (make-sum last-elem (augend (cdr s))))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p)
    (let ((last-elem (caddr p)))
        (if (null? (cdddr p))
            last-elem
            (make-product last-elem (multiplicand (cdr p))))))

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

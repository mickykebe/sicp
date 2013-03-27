(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        <more rules can be added here>
        (else (error "unknown expression type -- DERIV" exp))))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a) 1) The deriv rewrite above, dispatches on the version of the operators (in this case deriv) associated with the type at hand(+,*,...). 
;    2) To dispatch on the procedures number? and same-variable? is unnecessary because these procedures aren't acting on different types or representations of data to which different operations would be necessary. number? only checks whether the input is numeric and same-variable? checks the equality of two arguments. Neither of these processes require a separate definition as their logic is universal.

; b)
;N.B. The implementations for addend, augend, multiplier & multiplicand have to be modified as the expression being passed to them now doesn't include the operand
(define (install-add-deriv)
    (define (addend s) (car s))

    (define (augend s)
        (let ((last-elem (cadr s)))
            (if (null? (cddr s))
                last-elem
                (make-sum last-elem (augend (cdr s))))))

    (define (add-deriv operands var)
        (make-sum (deriv (addend operands) var)
                  (deriv (augend operands) var)))

    (put 'deriv '+ add-deriv))

(define (install-mul-deriv)
    (define (multiplier p) (car p))

    (define (multiplicand p)
        (let ((last-elem (cadr p)))
            (if (null? (cddr p))
                last-elem
                (make-product last-elem (multiplicand (cdr p))))))

    (define (mul-deriv operands var)
        (make-sum (make-product (multiplier operands)
                                (deriv (multiplicand operands) var))
                  (make-product (deriv (multiplier operands) var)
                                (multiplicand operands))))

    (put 'deriv '* mul-deriv))

; c) Exponentiation
(define (install-exp-deriv)
    (define (base exp)
        (car exp))

    (define (exponent exp)
        (cadr exp))

    (define (exp-deriv operands var)
        (let ((e (exponent operands))
              (b (base operands)))
            (make-product (make-product e 
                                        (make-exponentiation b (- e 1)))
                          (deriv b var))))

    (put 'deriv' '** exp-deriv))

; d) The exact same change when using the put procedure (adding to the table) would suffice. e.g. (put '+ 'deriv add-deriv)

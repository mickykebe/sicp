(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
    (let ((z (make-connector)))
        (multiplier x y z)
        z))

(define (c/ x y)
    (let ((z (make-connector)))
        (multiplier z y x)
        z))

(define (cv val)
    (let ((z (make-connector)))
        (constant val z)
        z))

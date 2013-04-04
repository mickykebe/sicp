;In the place of operations such as (sin, cos, +, *, sqrt, square, atan), their generic counter-parts will be used within the procedures manipulating the 4 parts of a complex number -- real-part, imag-part, mag, angle -- within each complex number package as well as within the equivalent procedures of the generic complex number package. For those operations with no generic counterparts, such as sin, cos, ..., one has to be defined.

; Generic definition of the operations listed above

; using square as an example

;genric procedure
(define (square num)
    (apply-generic 'square num))

;integer package
(define (square num)
    (* num num))

(put 'square '(integer) (lambda (x) (tag (square x))))

;rational package
(define (square num)
    (mul-rat num num))

(put 'square '(rational) (lambda (x) (tag (square x))))

;real package
(define (square num)
    (mul-real num num))

(put 'square '(real) (lambda (x) (tag (square x))))

;complex package

(define (square num)
    (mul-complex num num))

(put 'square '(complex) (lambda (x) (tag (square x))))

; Changes in each complex number package

; taking rectangular as an example

(define (magnitude z)
    (sqrt (add (square (real-part z))       ; notice here the square procedure is the generic version defined above
               (square (imag-part z)))))    ; add and sqrt should also be calls to their generic forms
  (define (angle z)
    (atan (imag-part z) (real-part z)))     ; atan is a call to its generic self
  (define (make-from-mag-ang r a) 
    (cons (mul r (cos a)) (mul r (sin a)))) ; cos, sin and mul are also generic calls

; changes in the generic-complex number package
(define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

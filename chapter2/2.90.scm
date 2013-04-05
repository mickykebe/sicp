;Sparse polynomial package
(define (install-sparse-poly-package)
  (define (make-poly variable term-list)
  (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
  ;; representation of terms and term lists
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))


  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (negate-poly p)
    (make-poly (variable p) (negate-terms (term-list p))))
  (define (negate-terms L)
    (if (empty-termlist? L)
      L
      (let ((t1 (first-term L)))
        (adjoin-term (negate-term t1)
                     (next-terms (rest-terms L))))))
  (define (negate-term term)
    (make-term (order term)
               (negate (coeff term))))

  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (add-poly p1 (negate p2))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

  (define (sparse-poly->dense-poly) (...))

  (define (sparse-poly-terms->dense-poly-terms) (...))

  (put-coercion 'sparse-poly 'dense-poly sparse-poly->dense-poly)

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'sparse-poly p))
  (put 'negate '(sparse-poly) 
       (lambda (p) (tag (negate-poly p))))
  (put 'add '(sparse-poly sparse-poly) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(sparse-poly sparse-poly)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(sparse-poly sparse-poly) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'sparse-poly
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

;Dense polynomial package
(define (install-dense-poly-package)
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

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))


  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (negate-poly p)
    (make-poly (variable p) (negate-terms (term-list p))))
  (define (negate-terms L)
    (if (empty-termlist? L)
      L
      (let ((t1 (first-term L)))
        (adjoin-term (negate-term t1)
                     (next-terms (rest-terms L))))))
  (define (negate-term term)
    (make-term (order term)
               (negate (coeff term))))

  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (add-poly p1 (negate p2))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

  (define (dense-poly->sparse-poly) (...))

  (define (dense-poly-terms->sparse-poly-terms) (...))

  (put-coercion 'dense-poly 'sparse-poly dense-poly->sparse-poly)

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'dense-poly p))
  (put 'negate '(dense-poly) 
       (lambda (p) (tag (negate-poly p))))
  (put 'add '(dense-poly dense-poly) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(dense-poly dense-poly)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(dense-poly dense-poly) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'dense-poly
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

; Generic polynomial package
(define (install-polynomial-package)
    (define (make-dense-poly var terms)
        ((get 'make 'dense-poly) var terms))

    (define (make-sparse-poly var terms)
        ((get 'make 'sparse-poly) var terms))

    (define (negate-poly p)
        (apply-generic 'negate p))

    (define (add-poly p1 p2)
        (apply-generic 'add p1 p2))

    (define (sub-poly p1 p2)
        (apply-generic 'sub p1 p2))

    (define (mul-poly p1 p2)
        (apply-generic 'mul p1 p2))

    (define (tag x) (attach-tag 'polynomial x))
    (put 'negate '(polynomial)
        (lambda (p) (tag (negate-poly p))))
    (put 'add '(polynomial polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put 'sub '(polynomial polynomial)
        (lambda (p1 p2) (tag (sub-poly p1 p2))))
    (put 'mul '(polynomial polynomial)
        (lambda (p1 p2) (tag (mul-poly p1 p2))))
    (put 'make-dense-polynomial 'polynomial
        (lambda (var terms) (tag (make-dense-poly var terms))))
    (put 'make-sparse-polynomial 'polynomial
        (lambda (var terms) (tag (make-sparse-poly var terms))))
  'done)

(define (make-dense-polynomial var terms)
    ((get 'make-dense-polynomial 'polynomial) var terms))

(define (make-sparse-polynomial var terms)
    ((get 'make-sparse-polynomial 'polynomial) var terms))

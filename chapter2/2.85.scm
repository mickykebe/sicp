(define (drop datum)
    (let ((datum-dropper (get 'drop (type-tag datum))))
        (if (null? datum-dropper)
            datum
            (if (equ? (raise (project datum)) datum)
                (drop (project datum))
                datum))))

(define (project num)
    (apply-generic project num))

;rational package
(define (project num)
    (make-integer (numer num)))

(put 'project 'rational project)

;real package
(define (project num)
    (make-integer (round num)))

(put 'project 'real project)

;complex package
(define (project num)
    (make-real (real-part num)))

(put 'project 'complex project)

;apply generic modified

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (> (length args) 1) 
                   (null? (filter (lambda (tag) (not (eq? (tag) (car type-tags)))) (cdr type-tags))))
              (drop (apply apply-generic op (bulk-raise args)))
              (error "No method for these types"
                     (list op type-tags)))))))

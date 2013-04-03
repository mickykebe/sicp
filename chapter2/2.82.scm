(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (> (length args) 1) 
                   (null? (filter (lambda (tag) (not (= (tag) (car type-tags)))) (cdr type-tags))))
              (let ((valid-coerc-procs 
                        (map (lambda (coerced-proc-list) 
                                (if (not (= (length coerced-proc-list) (length all-tags)))
                                    '()
                                    (car coerced-proc-list)))
                             (map (lambda (tag) (filter (lambda (coerc-proc) (not (null? coerc-proc))) 
                                                        (map (lambda (sub-tag) (get-coercion tag sub-tag)) 
                                                             all-tags)))
                                  all-tags))))
                    (if (null? valid-coerc-procs)
                        (error "No method for these types")
                        (apply apply-generic op (map (car valid-coerc-procs) args))))
              (error "No method for these types"
                     (list op type-tags)))))))

; Situation where the above procedure isn't general enough:
;   If for instance a subset of the arguments are convertable to one type and and the rest to another type, where the converts themselves can be converted to one distinct type.

;In general observing the data in a heirarchical format. The coercion logic of the procedure works only on those types whose immediate supertype is the same. If however the heirarchy were to be extended up where a subset of the arguments have one supertype and the remaining subset another, where both supertypes have the same supertypes, the procedure proves inadequate.

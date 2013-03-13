(define (subsets s)
  (if (null? s)
      (list s)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (append (list (car s)) x)) rest)))))

;By taking away the first element of the set and appending it to each element the SUBSET of the REMAINING set, one can obtain the subset of a set. The function above is a recursive implementation of this idea.

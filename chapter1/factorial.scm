(define (fact-iter num)
    (if (< num 2) 
        1 
        (* num (fact-iter (- num 1)))))

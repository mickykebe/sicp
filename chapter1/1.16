(define (expt b n) 
	(fast-expt-iter b n 1))

(define (expt-iter b n prod)
	(if (= n 0) 
		prod (expt-iter b (- n 1) (* prod b))))

(define (fast-expt b n)
	(cond   ((= n 0) 1)
            ((even? n) (square (fast-expt b (/ n 2))))
            (else (* b (fast-expt b (- n 1))))))

(define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (square b) (/ n 2) (a)))
          (else (fast-expt-iter b (- n 1) (* b a)))))

(define (even? n)
    (= (remainder n 2) 0))

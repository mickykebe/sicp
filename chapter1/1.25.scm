(define (fast-expt b n)
	(cond   ((= n 0) 1)
            ((even? n) (square (fast-expt b (/ n 2))))
            (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
    (remainder (fast-expt base exp) m))

;; Recursive soln.
(define (f n)
    (if (< n 3) n (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

;;Iterative Soln.
(define (f n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          ((= n 2) 2)
          (else (f-iter 0 1 2 2 n))))

(define (f-iter min3 min2 min1 cur n)
    (cond ((= cur n) min1)
          (else (f-iter min2 min1 (+ min1 (* 2 min2) (* 3 min3)) (+ cur 1) n))))

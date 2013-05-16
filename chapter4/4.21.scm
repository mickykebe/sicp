;a
((lambda (n) 
    ((lambda (fib) (fib fib n))
            (lambda (fb n)
                (if (< n 2)
                    1
                    (+ (fb fb (- n 1)) (fb fb (- n 2))))))) 4)

;b
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))

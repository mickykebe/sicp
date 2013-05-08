;Owing to my laziness I have failed to implement the procedure to generate a stream of random numbers within a range.
;So i've stolen it from weiqun. http://wqzhang.wordpress.com/2009/09/10/sicp-exercise-3-82/ (Hope you don't mind)
(define (random-in-range low high init)
  (define random-max 12344)
  (define random-numbers
    (cons-stream init
                 (stream-map rand-update random-numbers)))
  (define (rand-update x)
    (let ((a (expt 2 32))
          (c 1103515245)
          (m 12345))
      (modulo (+ (* a x) c) m)))
  (let ((range (- high low)))
    (stream-map (lambda (x) 
                  (+ low (* range (/ x random-max))))
                random-numbers)))

;My section:
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (integral-estimates p x1 x2 y1 y2)
    (define (exp-stream)
        (define r1 (random-in-range x1 x2 x1))
        (define r2 (random-in-range y1 y2 y1))
        (stream-map p r1 r2))
    (stream-map (lambda (i)
                    (* (* (- x2 x1) (- y2 y1))
                       i))
                (monte-carlo exp-stream 0 0)))

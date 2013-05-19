(eval '(define (fact n) (if (= n 1) 1 (* n (fact (- n 1))))) the-global-environment)
;Test
;(fact 2000)
(with-timings (lambda () 
                (eval '(fact 2000) the-global-environment)) 
              (lambda (run-time gc-time real-time)
                (write (internal-time/ticks->seconds real-time))
                (newline)))

;without analyze:
real-time: 1.295
;with analyze:
real-time: .494

;(fact 4000)
(with-timings (lambda () 
                (eval '(fact 4000) the-global-environment)) 
              (lambda (run-time gc-time real-time)
                (write (internal-time/ticks->seconds real-time))
                (newline)))

;without analyze:
real-time: 1.711
;with analyze:
real-time: 1.087

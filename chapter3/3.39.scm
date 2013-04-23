(define x 10)

(define s (make-serializer))

(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

;121: P2 finishes -> P1 executes
;101: P1 finishes -> P2 executes
;100: The serialized proc in P1 finishes -> P2 finishes -> Inside P1, x is assigned the result of the first step

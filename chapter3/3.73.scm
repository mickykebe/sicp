(define (RC R C dt)
    (lambda (i v0)
        (define v (cons-stream v0 
                               (stream-map (lambda (vx) (* (/ 1.0 C) vx))
                                           (add-streams (stream-map (lambda (ix) (+ (* ix dt)
                                                                                    (* ix R)))
                                                                    i)
                                                        v))))
        v))

(define RC1 (RC 5 1 0.5))

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

;Fraction division.

(expand 1 7 10) ; digits of (1/7)

;(cons-stream 1 (delay (expand 3 7 10)))
;(cons-stream 1 (cons-stream 4 (delay (exapnd 2 7 10))))
;(cons-stream 1 (cons-stream 4 (cons-stream 2 (delay (expand 6 7 10)))))
;(cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (delay (expand 4 7 10))))))
;(cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (cons-stream 5 (delay (expand 5 7 10)))))))
;(cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (cons-stream 5 (cons-stream 7 (delay (expand 1 7 10))))))))
;(cons-stream 1 (cons-stream 4 (cons-stream 2 (cons-stream 8 (cons-stream 5 (cons-stream 7 (cons-stream 1 (cons-stream 4 (delay ...

;a stream of 1 4 2 8 5 7 1 4

(expand 3 8 10) ; digits of 3/8

;(cons-stream 3 (delay (expand 6 8 10)))
;(cons-stream 3 (cons-stream 7 (delay (expand 4 8 10))))
;(cons-stream 3 (cons-stream 7 (cons-stream 5 (delay (expand 0 8 10)))))

;3 7 5 0 0

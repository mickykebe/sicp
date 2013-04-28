(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; changes:

;(stream-enumerate-interval 1 20) => (cons-stream 1 
;--------------------------------                 (delay 
;                   |                               (stream-enumerate-interval 2 20)))
;                   |
;                   |
;                   v
;(stream-map accum ( )) => (cons-stream 1 
;                                       (delay (stream-map accum 
;                                                          (cons-stream 2 
;                                                                       (delay (stream-enumerate-interval 3 20))))))
;sum = 1
(define y (stream-filter even? seq))
; (stream-filter even? (cons-stream 1 
;                                   (delay (stream-map accum 
;                                                      (cons-stream 2 
;                                                                   (delay (stream-enumerate-interval 3 20))))))
; sum = 1

; (stream-filter even? (cons-stream 3
;                                   (delay (stream-map accum
;                                                      (cons-stream 3 (delay (stream-enumerate-interval 4 20)))))))
; sum = 3

; (stream-filter even? (cons-stream 6
;                                   (delay (stream-map accum 
;                                                      (cons-stream 4 (delay (stream-enumerate-interval 5 20)))))))
; sum = 6

; (cons-stream 6
;              (delay (stream-filter even? 
;                                    (cons-stream 10
;                                                 (delay (stream-map accum
;                                                                    (cons-stream 5 
;                                                                                 (delay (stream-enumerate-interval 6 20)))))))))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))

; sum = 10

(stream-ref y 7)

; i 1 2 3 4  5  6  7  8  9  10 11 12 13 14  15  16
; s 1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136
; sum = 136

(display-stream z)

; 10 15 45 55 105 120 ...

; The results would be different because on this occasion we've relied on the memoization to keep the value of accum consistent for any value of x. In other words, in the above scheme once (accum x) has been called via delay once, calling it through delay any number of times produces the same result. However without memoization once accum is called with one value, calling it with the same value again and again always produces different results because the result depends on "sum" which always increases with every call to accum.

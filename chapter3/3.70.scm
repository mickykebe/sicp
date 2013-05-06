(define (merge-weighted s1 s2 weight-proc)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car-weight (weight-proc (stream-car s1)))
               (s2car-weight (weight-proc (stream-car s2))))
           (if (< s1car-weight s2car-weight)
               (cons-stream (stream-car s1) (merge-weighted (stream-cdr s1) s2 weight-proc))
               (cons-stream (stream-car s2) (merge-weighted s1 (stream-cdr s2) weight-proc))))))))

(define (weighted-pairs s t weight-proc)
    (cons-stream
        (list (stream-car s) (stream-car t))
        (merge-weighted
            (stream-map (lambda (x) (list (stream-car s) x))
                        (stream-cdr t))
            (weighted-pairs (stream-cdr s) (stream-cdr t) weight-proc)
            weight-proc)))

;a
(define ordered-pairs1 (weighted-pairs integers
                                       integers
                                       (lambda (x) (+ (car x) (cadr x)))))

(display-n-stream ordered-pairs1 10)
;(1 1)
;(1 2)
;(2 2)
;(1 3)
;(2 3)
;(1 4)
;(3 3)
;(2 4)
;(1 5)
;(3 4)

;b
(define ordered-pairs2 (stream-filter (lambda (pair)
                                        (let ((i (car pair))
                                              (j (cadr pair)))
                                            (not (or (divisible? i 2) (divisible? j 2)
                                                     (divisible? i 3) (divisible? j 3)
                                                     (divisible? i 5) (divisible? j 5)))))
                                   (weighted-pairs integers
                                                   integers
                                                   (lambda (pair)
                                                       (let ((i (car pair))
                                                             (j (cadr pair)))
                                                           (+ (* 2 i) (* 3 j) (* 5 i j)))))))
(display-n-stream ordered-pairs2 10)
;(1 1)
;(1 7)
;(1 11)
;(1 13)
;(1 17)
;(1 19)
;(1 23)
;(1 29)
;(1 31)
;(7 7)

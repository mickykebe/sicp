(define (ramanujan-weight pair)
    (let ((i (car pair))
          (j (cadr pair)))
        (+ (* i i i) (* j j j))))

(define ramanujan-weighted-pairs (weighted-pairs integers
                                                 integers
                                                 ramanujan-weight))

(define (search-pairs pairs weight-proc n)
    (if (> n 0)
        (let ((cur (stream-car pairs))
              (next (stream-car (stream-cdr pairs))))
            (cond ((= (weight-proc cur) (weight-proc next))
                    (display (weight-proc cur))
                    (display "\n")
                    (search-pairs (stream-cdr pairs) weight-proc (- n 1)))
                  (else (search-pairs (stream-cdr pairs) weight-proc n))))))

(search-pairs ramanujan-weighted-pairs ramanujan-weight 6)
;1729
;4104
;13832
;20683
;32832
;39312

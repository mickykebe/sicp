(define (square-sum-weight pair)
    (let ((i (car pair))
          (j (cadr pair)))
        (+ (* i i) (* j j))))

(define square-sum-pairs (weighted-pairs integers
                                          integers
                                          square-sum-weight))

(define (search-pairs pairs weight-proc n)
    (if (> n 0)
        (let ((cur (stream-car pairs))
              (next (stream-car (stream-cdr pairs)))
              (then (stream-car (stream-cdr (stream-cdr pairs)))))
            (cond ((= (weight-proc cur) (weight-proc next) (weight-proc then))
                    (display (weight-proc cur))
                    (display "\n")
                    (search-pairs (stream-cdr pairs) weight-proc (- n 1)))
                  (else (search-pairs (stream-cdr pairs) weight-proc n))))))

(search-pairs square-sum-pairs square-sum-weight 6)
;325
;425
;650
;725
;845
;850

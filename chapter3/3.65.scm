(define (ln2-summands n)
    (cons-stream (/ 1.0 n) 
                 (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream (partial-sums (ln2-summands 1)))

(display-n-stream ln2-stream 9)
;1.
;.5
;.8333333333333333
;.5833333333333333
;.7833333333333332
;.6166666666666666
;.7595238095238095
;.6345238095238095
;.7456349206349207

(define ln2-eu-trans (euler-transform ln2-stream))

(display-n-stream ln2-eu-trans 9)
;.7
;.6904761904761905
;.6944444444444444
;.6924242424242424
;.6935897435897436
;.6928571428571428
;.6933473389355742
;.6930033416875522
;.6932539682539683

(define ln2-accelerated (accelerated-sequence euler-transform ln2-stream))

(display-n-stream ln2-accelerated 9)
;1.
;.7
;.6932773109243697
;.6931488693329254
;.6931471960735491
;.6931471806635636
;.6931471805604039
;.6931471805599445
;.6931471805599427
;.6931471805599454

;Considering ln2 = 0.693147180559945309417232121458, the convergence rate increases from top to bottom. Quite markedly.

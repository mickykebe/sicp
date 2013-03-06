(define (count-change num)
    (cc num 5))

(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount (- kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kind-of-coin)
    (cond ((= kind-of-coin 1) 1)
          ((= kind-of-coin 2) 5)
          ((= kind-of-coin 3) 10)
          ((= kind-of-coin 4) 25)
          ((= kind-of-coin 5) 50)))

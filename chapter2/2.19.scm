(define (cc amount coin-values)
    (cond   ((= amount 0) 1)
            ((or (< amount 0) (no-more? coin-values)) 0)
            (else (+    (cc (- amount (first-denomination coin-values)) coin-values)
                        (cc amount (except-first-denomination coin-values))))))

(define (no-more? items)
    (null? items))

(define (first-denomination items)
    (car items))

(define (except-first-denomination items)
    (cdr items))

; The order of coins doesn't affect the result b/c cc in defined in a way where all the helper functions are working in tandem with one list of coins.

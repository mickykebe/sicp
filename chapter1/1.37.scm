(define (cont-frac n d k)
    (define (iter i)
        (if (> i k)
            0
            (/ (n i) (+ (d i) (iter (+ i 1))))))
    (iter 1))

; 11

(define (cont-frac n d k)
    (define (iter i result)
        (if (> i k)
            result
            (iter (+ i 1) (/ (n i) (+ (d i) result)))))
    (iter 1 0))

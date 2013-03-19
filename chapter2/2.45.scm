(define (split big-joiner small-joiner)
    (lambda (painter n) 
        (if (= n 0)
            painter
            (let ((small ((split big-joiner small-joiner) painter (- n 1))))
                (big-joiner painter (small-joiner small small))))))

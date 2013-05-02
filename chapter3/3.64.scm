(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit s tolerance)
    (let ((e1 (stream-car s))
          (e2 (stream-car (stream-cdr s))))
        (let ((diff (abs (- e1 e2))))
            (if (< diff tolerance)
                e2
                (stream-limit (stream-cdr s) tolerance)))))

(define (div-series num-s den-s)
    (if (= (stream-car den-s) 0)
        (error "Division by 0")
        (mul-series num-s (invert-unit-series den-s))))

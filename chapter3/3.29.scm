(define (or-gate o1 o2 output)
    (let ((neg-o1 (make-wire))
          (neg-o2 (make-wire))
          (and-neg (make-wire)))
        (inverter o1 neg-o1)
        (inverter o2 neg-o2)
        (and-gate neg-o1 neg-o2 and-neg)
        (inverter and-neg output)
        'ok))

;or-delay = 3*inverter-delay + and-gate-delay

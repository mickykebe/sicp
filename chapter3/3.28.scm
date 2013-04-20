(define (or-gate o1 o2 output)
    (define (or-action-procedure)
        (let ((new-signal (logical-or (get-signal o1) (get-signal o2))))
            (after-delay or-gate-delay
                         (lambda ()
                            (set-signal! output new-signal)))))
    (add-action! o1 or-action-procedure)
    (add-action! o2 or-action-procedure)
    'ok)

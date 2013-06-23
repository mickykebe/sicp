;Cond
    ;Under eval-dispatch

    (test (op cond?) (reg exp))
    (branch (label ev-cond))

    ;Implementation

    ev-cond
    (assign exp (op cond->if) (reg exp))
    (goto (label eval-dispatch))

;Let
    ;Under eval-dispatch

    (test (op let?) (reg exp))
    (branch (label ev-let))

    ;Implementation

    ev-let
    (assign exp (op let->combination) (reg exp))
    (goto (label eval-dispatch))

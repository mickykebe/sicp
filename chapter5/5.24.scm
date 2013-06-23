;Caveats:
;   last-clause? operation not defined
;   else-clause-not-last label not defined

ev-cond
    (assign exp (op cond-clauses) (reg exp))
cond-loop
    (test (op null?) (reg exp))
    (branch (label false-cond))
    (assign unev (op first) (reg exp))
    (test (op cond-else-clause?) (reg unev))
    (branch (label ev-cond-else-clause))
    (save exp)
    (save unev)
    (save env)
    (save continue)
    (assign continue (label check-cond))
    (assign exp (op cond-predicate) (reg unev))
    (goto (label dispatch-eval))
check-cond
    (restore continue)
    (restore env)
    (restore unev)
    (restore exp)
    (test (op true?) (reg value))
    (branch (label eval-cond-actions))
    (assign exp (op rest) (reg exp))
    (goto (label cond-loop))
ev-cond-else-clause
    (test (op last-clause?) (reg exp))
    (branch (label eval-cond-actions))
    (goto (label else-clause-not-last))
eval-cond-actions
    (assign unev (op cond-actions) (reg unev))
    (save continue)
    (goto (label ev-sequence))
false-cond
    (assign val (const false))
    (goto (reg continue))


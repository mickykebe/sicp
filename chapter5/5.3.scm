;I won't draw the data-path diagram. Too tedious.

;Primitivized version:
(controller
    (assign guess (const 1))
    sqrt-iter
    (test (op good-enough?) (reg guess))
    (branch (label done))
    (assign x (op improve) (reg guess))
    (assign guess (reg x))
    (goto (label sqrt-iter))
    done)

;Expanded Version:
(controller
    (assign guess (const 1))
    sqrt-iter
    ;good-enough-start
    (assign t1 (op square) (reg guess))
    (assign t2 (op -) (reg t1) (reg x))
    (assign t3 (op abs) (reg t2))
    (test (op <) t3 (const 0.001))
    ;good-enough-end
    (branch (label done))
    ;improve-start
    (assign t4 (op /) (reg x) (reg guess))
    (assign t5 (op average) (reg guess) (reg t4))
    ;improve-end
    (assign guess (reg t5))
    (goto (label sqrt-iter))
    done)

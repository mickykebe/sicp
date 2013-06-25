;a)
ev-application
    (save continue)
    (assign unev (op operands) (reg exp))
    (assign exp (op operator) (reg exp))
    (test (op variable?) (reg exp))
    (branch (label ev-appl-symbol-operator))
    (save env)
    (save unev)
    (assign continue (label ev-appl-did-operator))
    (goto (label eval-dispatch))
    ev-appl-symbol-operator
        (assign continue (label ev-appl-operator-finished))
        (goto (label eval-dispatch))
    ev-appl-did-operator
        (restore unev)
        (restore env)
    ev-appl-operator-finished
        (assign argl (op empty-arglist))
        (assign proc (reg val))
        (test (op no-operands?) (reg unev))
        (branch (label apply-dispatch))
        (save proc)
    ev-appl-operand-loop
;   .
;   .
;   .

;b)
;The optimization is only an additional feature the compiler can implement elegantly. Even if optimizations were incorporated in the evaluator, there still wouldn't be getting away from what's in the nature of the evaluator which is to analyze each expression one at a time. The compilation method obviates such analysis during actual evaluation by ensuring it's done only once.
;A related difference is that all optimization is done once during compilation, but is a part of the evaluation process in the interpreter.

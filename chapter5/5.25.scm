;Application-evaluation
ev-application
        (save continue)
        (save env)
        (assign unev (op operands) (reg exp))
        (save unev)
        (assign exp (op operator) (reg exp))
        (assign continue (label ev-appl-did-operator))
        (goto (label eval-dispatch))
    ev-appl-did-operator
        (restore unev)
        (restore env)
        (assign argl (op empty-arglist))
        (assign val (op force-it) (reg val)) ;; Operand is forced in case it's a thunk
        (assign proc (reg val))
    apply-dispatch
        (test (op primitive-procedure?) (reg proc))
        (branch (label primitive-apply))
        (test (op compound-procedure?) (reg proc))
        (branch (label compound-apply))
        (goto (label unknown-procedure-type))
    primitive-apply
        (save proc)
    ev-appl-operand-loop    ;;Loop that builds the actual value list from the argument list
        (save argl)
        (assign exp (op first-operand) (reg unev))
        (test (op last-operand?) (reg unev))
        (branch (label ev-appl-last-arg))
        (save env)
        (save unev)
        (assign continue (label ev-appl-accumulate-arg))
        (goto (label eval-dispatch))
    ev-appl-accumulate-arg
        (restore unev)
        (restore env)
        (restore argl)
        (assign val (op force-it) (reg val))    ;;Forces the argument
        (assign argl (op adjoin-arg) (reg val) (reg argl))
        (assign unev (op rest-operands) (reg unev))
        (goto (label ev-appl-operand-loop))
    ev-appl-last-arg
        (assign continue (label ev-appl-accum-last-arg))
        (goto (label eval-dispatch))
    ev-appl-accum-last-arg
        (restore argl)
        (assign argl (op adjoin-arg) (reg val) (reg argl))
    ev-primitive
        (restore proc)
        (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
        (restore continue)
        (goto (reg continue))
    compound-apply
    ev-delay-operand-loop   ;;Loop that builds the delayed list passed to the compound procedure
        (test (op null?) (reg unev))
        (branch (label ev-appl-comp-proc))
        (assign exp (op first-operand) (reg unev))
        (assign val (op delay-it) (reg exp))
        (assign argl (op adjoin-arg) (reg val) (reg unev))
        (assign unev (op rest-operands) (reg unev))
        (goto (label ev-delay-operand-loop))
    ev-appl-comp-proc
        (assign unev (op procedure-parameters) (reg proc))
        (assign env (op procedure-environment) (reg proc))
        (assign env (op extend-environment) (reg unev) (reg argl) (reg env))
        (assign unev (op procedure-body) (reg proc))
        (goto (label ev-sequence))

;If-evaluation
ev-if
        (save exp)
        (save env)
        (save continue)
        (assign continue (label ev-if-decide))
        (assign exp (op if-predicate) (reg exp))
        (goto (label eval-dispatch))
    ev-if-decide
        (restore continue)
        (restore env)
        (restore exp)
        (assign val (op force-it) (reg val)) ;;Only addition necessary
        (test (op true?) (reg val))
        (branch (label ev-if-consequent))
    ev-if-alternative
        (assign exp (op if-alternative) (reg exp))
        (goto (label eval-dispatch))
    ev-if-consequent
        (assign exp (op if-consequent) (reg exp))
        (goto (label eval-dispatch))

(define fact-iter-inst-seq
    (compile '(define (factorial n)
                  (define (iter product counter)
                    (if (> counter n)
                        product
                        (iter (* counter product)
                              (+ counter 1))))
                  (iter 1 1))
             'val
             'next))

(display-insts fact-iter-inst-seq)

;Result

;; construct factorial and skip over code for the procedure body
(assign val (op make-compiled-procedure) (label entry71) (reg env))
(goto (label after-lambda70))
entry71 ;;factorial body starts here
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (n)) (reg argl) (reg env))
;;construct iter and skip over it's body
(assign val (op make-compiled-procedure) (label entry76) (reg env))
(goto (label after-lambda75))
entry76
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (product counter)) (reg argl) (reg env))
(save continue)
(save env)
;;compute (> counter n)
(assign proc (op lookup-variable-value) (const >) (reg env))
(assign val (op lookup-variable-value) (const n) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const counter) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch91))
compiled-branch90
(assign continue (label after-call89))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch91
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call89
;;val now contains value of (> counter n)
(restore env)
(restore continue)
(test (op false?) (reg val))    ;;val is tested before branching is done
(branch (label false-branch78))
true-branch79 ;;returns product
(assign val (op lookup-variable-value) (const product) (reg env))
(goto (reg continue))
false-branch78
;;compute and return (iter (* counter product) (+ counter 1))
(assign proc (op lookup-variable-value) (const iter) (reg env))
(save continue)
(save proc)
(save env)
;;compute (+ counter 1)
(assign proc (op lookup-variable-value) (const +) (reg env))
(assign val (const 1))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const counter) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch85))
compiled-branch84
(assign continue (label after-call83))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch85
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call83
;;val now contains value of (+ counter 1)
(assign argl (op list) (reg val))
(restore env)
(save argl)
;;compute (* counter product)
(assign proc (op lookup-variable-value) (const *) (reg env))
(assign val (op lookup-variable-value) (const product) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const counter) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch82))
compiled-branch81
(assign continue (label after-call80))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch82
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call80
;;val now contains value of (* counter product)
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
;;argl now contains the two values computed
(restore proc)
(restore continue) ;;*** Here continue is restored to it's original value. Notice it isn't saved before iter is called again ***
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch88))
compiled-branch87 ;;Iter is called here without setting up the stack for a return address ensuring the property of tail recursion.
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch88
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call86
after-if77
after-lambda75
;;assigns the procedure to the variable iter inside 
(perform (op define-variable!) (const iter) (reg val) (reg env))
(assign val (const ok))
;;executes (iter 1 1)
(assign proc (op lookup-variable-value) (const iter) (reg env))
(assign val (const 1))
(assign argl (op list) (reg val))
(assign val (const 1))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch74))
compiled-branch73
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch74
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call72
after-lambda70
;;assign the procedure to the variable factorial
(perform (op define-variable!) (const factorial) (reg val) (reg env))
(assign val (const ok))

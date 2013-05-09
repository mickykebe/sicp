;a
;Since we're using pairs to check whether an expression is a procedure application, not to interfere with other conditions which happen to be pairs with a more specialized form of identification, it has to either come last or also adopt a similar specialization.

;b
(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))

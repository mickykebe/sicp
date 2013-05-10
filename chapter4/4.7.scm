(define (let*? exp) (tagged-list? exp 'let*))
(define (let-var-exp-seq exp) (cadr exp))
(define (let-body exp) (cddr exp))
(define (first-var-exp var-exp-seq) (car var-exp-seq))
(define (last-var-exp? var-exp-seq) (null? (cdr var-exp-seq)))

(define (let*->nested-lets exp)
    (define (transform-iter var-exp-seq)
        (if (last-var-exp? var-exp-seq)
            (make-let (list (first-var-exp var-exp-seq)) (let-body exp))
            (make-let (list (first-var-exp var-exp-seq)) (transform-iter (cdr var-exp-seq)))))
    (transform-iter (let-var-exp-seq exp)))

;yes
;to be added to eval
((let*? exp) (eval (let*->nested-lets exp) env))

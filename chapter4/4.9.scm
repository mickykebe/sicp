;do implemented according to http://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/Iteration.html
(define (do? exp) (tagged-list? exp 'do))

(define (do-var-init-step-seq exp) (cadr exp))
(define (do-test-exps exp) (caddr exp))
(define (do-body exp) (cdddr exp))

(define (do-variables exp) (map car (do-var-init-step-seq exp)))
(define (do-inits exp) (map cadr (do-var-init-step-seq exp)))
(define (do-steps exp) (map caddr (do-var-init-step-seq exp)))
(define (do-test exp) (car (do-test-exps exp)))
(define (do-end-exps exp) (cdr (do-test-exps exp)))

(define (make-let-bindings vars exps) (map (lambda (var exp) (list var exp)) vars exps))
(define (do->combination exp)
    (sequence->exp (list (make-define 'do_iter (make-lambda (do-variables exp)
                                                            (make-if (do-test exp)
                                                                     (do-end-exps exp)
                                                                     (append (do-body exp)
                                                                             (cons 'do_iter (do-steps exp))))))
                         (cons 'do_iter (do-inits exp)))))

;Inside eval
((if-fail? exp) (analyze-if-fail exp))

;Rest
(define (if-fail? exp) (tagged-list? exp 'if-fail))
(define (if-fail-predicate exp) (cadr exp))
(define (if-fail-alternate exp) (caddr exp))

(define (analyze-if-fail exp)
    (let ((pproc (analyze (if-fail-predicate exp)))
          (aproc (analyze (if-fail-alternate exp))))
        (lambda (env succeed fail)
            (pproc env
                   (lambda (val fail2)
                        (succeed val fail2))
                   (lambda ()
                        (aproc env
                               (lambda (val fail2)
                                    (succeed val fail2))
                               fail))))))

(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)
;Result
;;; Amb-Eval value:
;all-odd

(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)

;Result
;;; Amb-Eval value:
;8

;change of lambda to to:
;((lambda [params])
;    [body])

(define (lambda? exp)
    (if (pair? exp)
        (tagged-list? (car exp) 'lambda)
        false))

(define (lambda-parameters exp) (cadr (car exp)))
(define (lambda-body exp) (cdr exp))
(define (make-lambda parameters body)
  (cons (cons 'lambda parameters) body))

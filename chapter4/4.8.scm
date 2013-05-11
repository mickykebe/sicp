(define (make-define name body)
    (list 'define name body))

(define (name named-let-exp) (cadr named-let-exp))
(define (named-let? exp) (symbol? (name exp)))
(define (let->combination exp)
    (let ((lambda-proc (make-lambda (let-vars exp) 
                                    (let-body exp))))
        (if (named-let? exp)
            (make-define (name exp) lambda-call))
        (cons lambda-proc (let-exps exp))))



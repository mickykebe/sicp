;I assume that changes made in 4.2 persist
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else ((get 'eval (car exp)) exp env))))

(define (install-quoted-eval)
    (define (text-of-quotation exp) (cadr exp))
    (define (eval exp env)
        (text-of-quotation exp)
    (put 'eval 'quote eval))

(define (install-assignment-eval)
    (define (assignment-variable exp) (cadr exp))
    (define (assignment-value exp) (caddr exp))
    (define (eval-assignment exp env)
      (set-variable-value! (assignment-variable exp)
                           (eval (assignment-value exp) env)
                           env)
      'ok)
    (define (eval exp env)
        (eval-assignment exp env))

    (put 'eval 'set! eval))

(define (install-definition-eval)
    (define (definition-variable exp)
      (if (symbol? (cadr exp))
          (cadr exp)
          (caadr exp)))
    (define (definition-value exp)
      (if (symbol? (cadr exp))
          (caddr exp)
          (make-lambda (cdadr exp)   ; formal parameters
                       (cddr exp)))) ; body
    (define (eval-definition exp env)
      (define-variable! (definition-variable exp)
                        (eval (definition-value exp) env)
                        env)
      'ok)
    (define (eval exp env)
        (eval-definition exp env))
    (put 'eval 'define eval))

;etc...

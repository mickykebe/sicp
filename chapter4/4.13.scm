;special-form of make-unbound:
;(make-unbound [var])

;Inside eval
;   (cond ...
;       .
;       .
        ((unbound? exp) (eval-unbound exp env))
;       .
;       .
;       .)


;Doesn't make sense to unbind a symbol in the parent environments of the environment in which make-unbound is executed.
;Could spell disaster for other children environments unconcerned about some naughty child unbinding a symbol, they use, defined in the parent.
(define (unbound? exp) (tagged-list? exp 'make-unbound))
(define (unbound-var exp) (cadr exp))
(define (eval-unbound exp env)
    (let ((var (unbound-var exp))
          (frame (first-frame env)))
        (set-car! env (unbound-frame var frame))))

(define the-empty-frame (cons '() '()))

;Returns a new frame, same as the argument frame except the var.
(define (unbound-frame var frame)
    (define (unbound variables values)
        (cond ((null? variables) the-empty-frame)
              ((eq? var (car variables)) (cons (cdr variables) (cdr values)))
              (else (let ((next-seq (unbound (cdr variables) (cdr values))))
                            (cons (cons (car variables) (car next-seq))
                                  (cons (car values) (cdr next-seq)))))))
    (unbound (frame-variables frame) (frame-values frame)))

;condition inside eval
((unless? exp) (analyze (unless->if exp)))

;Rest
(define (unless? exp) (tagged-list? exp 'unless))

(define (unless-condition exp) (cadr exp))
(define (unless-usual-value exp) (caddr exp))
(define (unless-exceptional-value exp) (cadddr exp))
(define (unless->if exp)
    (make-if (unless-condition exp)
             (unless-exceptional-value exp)
             (unless-usual-value exp)))

;Had unless been defined as a procedure we could have built on the abstration properties including passing it to a procedure, returning it as the result of one etc.

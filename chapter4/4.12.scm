;Generic lookup,set,and define.
;(can be used with any representation of frames)
(define (lookup-variable-value var env)
    (define (lookup env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (if (in-frame? var frame)
                    (frame-get-value var frame)
                    (lookup (enclosing-environment env))))))
    (lookup env))

(define (set-variable-value! var val env)
    (define (set env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET!" var)
            (let ((frame (first-frame env)))
                (if (in-frame? var frame)
                    (frame-set-value var val frame)
                    (set (enclosing-environment env))))))
    (set env))

(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (if (in-frame? var frame)
            (frame-set-value var val frame)
            (add-binding-to-frame! var val frame))))

;Frame-specific-implementations
;(Have to be implemented per frame implementation)

;For book's frame implementation:
(define (in-frame? var frame)
    (define (in? variables)
        (cond ((null? variables) false)
              ((eq? var (car variables)) true)
              (else (in? (cdr variables)))))
    (in? (frame-variables frame)))

(define (frame-get-value var frame)
    (define (get variables values)
        (if (eq? var (car variables))
            (car values)
            (get (cdr variables) (cdr values))))
    (get (frame-variables frame) (frame-values frame)))

(define (frame-set-value var val frame)
    (define (set variables values)
        (if (eq? var (car variables))
            (set-car! values val)
            (set (cdr variables) (cdr values))))
    (set (frame-variables frame) (frame-values frame)))

;Abstraction beyond this level is definitely achievable, but I think it comes at the expense of readability.

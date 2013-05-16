(define UNASSIGNED_SYMBOL '*unassigned*)

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) UNASSIGNED_SYMBOL)
                 (error "Unassigned variable -- Lookup" var)
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;better
(define (scan-out-defines body-exps)
    ;Retrieves the definition expressions
    (define (define-exps body-exps)
        (cond ((null? body-exps) '())
              ((definition? (car body-exps)) (cons (car body-exps) (define-exps (cdr body-exps))))
              (else (define-exps (cdr body-exps)))))
    ;Produces ( ((u '*unassigned*) (set! u <e1>)) ((v '*unassigned*) (set! v <e2>)) ...)
    (define (make-var-bod-seq define-exps)
        (map (lambda (exp)
                (let ((var (definition-variable exp)))
                    (cons (list var ''*unassigned*)
                          (list 'set! var (definition-value exp)))))
            define-exps))
    ;Retreives the non-definition expressions
    (define (rest-exps body-exps)
        (cond ((null? body-exps) '())
              ((definition? (car body-exps)) (rest-exps (cdr body-exps)))
              (else (cons (car body-exps) 
                          (rest-exps (cdr body-exps))))))
    (let ((seq (make-var-bod-seq (define-exps body-exps))))
        (if (null? seq)
            body-exps
            (list (make-let (map car seq) 
                            (sequence->exp (append (map cdr seq) 
                                                   (rest-exps body-exps))))))))


;Better to modify make-procedure. "scanning out" will be done once, whereas it would have been done every time a procedure is executed if it were called inside procedure-body.

(define (make-procedure parameters body env)
    (list 'procedure parameters (scan-out-defines body) env))

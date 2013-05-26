;Inside the ME cons should be defined as follows
(define (cons x y)
  (list-lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

;Core of the evaluator
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((list-lambda? exp)
         (make-list-procedure (lambda-parameters exp)
                              (lambda-body exp)
                              env))  ;inserted
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ;-----------ex4.4------------------------
        ((and? exp) (eval-and (and-operands exp) env))
        ((or? exp) (eval-or (or-operands exp) env))
        ;----------------------------------------
        ;-----------ex4.6------------------------
        ((let? exp) (eval (let->combination exp) env))
        ;----------------------------------------
        ;-----------ex4.7------------------------
        ((let*? exp) (eval (let*->nested-lets exp) env))
        ;----------------------------------------
        ;-----------ex4.20------------------------
        ((letrec? exp) (eval (letrec->combination exp) env))
        ;-----------------------------------------
        ((application? exp)
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
         (error "Unknown expression type -- EVAL" exp))))


(define (list-lambda? exp) (tagged-list? exp 'list-lambda))
(define (make-list-procedure parameters body env)
    (list 'list-proc parameters body env))
(define (list-procedure? exp)
    (tagged-list? exp 'list-proc))

(define (compound-procedure? p) ;changed
  (or (tagged-list? p 'procedure) (tagged-list? p 'list-proc)))

(define (to-displayable-list exp)
    (define max-elems 10)
    (define (transform exp n)
        (cond ((= n 0) '...)
              ((not (list-procedure? exp)) exp)
              (else (let ((car-val (force-it (apply exp '((lambda (x y) x)) (procedure-environment exp))))
                          (cdr-val (force-it (apply exp '((lambda (x y) y)) (procedure-environment exp)))))
                        (cons (transform car-val max-elems)
                              (transform cdr-val (- n 1)))))))
    (transform exp max-elems))

(define (user-print object)
  (if (compound-procedure? object)
      (if (list-procedure? object)
          (display (to-displayable-list object))
          (display (list 'compound-procedure
                         (procedure-parameters object)
                         (procedure-body object)
                         '<procedure-env>)))
      (display object)))

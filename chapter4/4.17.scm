;sequential

;GE ((primitives)())
(define (p a)
    (define x <e1>)
    (define y <e2>)
    <e3>)
;GE((primitives (p, ('procedure <p params> <p body>))) empty-env)
(p 3)
;E1(((a, 3) (x, <e1 evaluated>) (y <e2 evaluated>)) GE)
;N.B. x and y are bound after execution of the body

;scoped out
;GE ((primitives)())
(define (p a)
    (define x <e1>)
    (define y <e2>)
    <e3>)
;E1((primitives (p, ('procedure <p-params> <scoped-out-body>))) empty-env)
;N.B. Here empty-env = (let ((x '*unassigned*) (y '*unassigned*)) (set! x <e1>) (set! y <e2>) <e3>)
(p 3)
;E1(((a, 3)) GE)
;(call to (procedure (x y)  ((set! x <e1>) (set! y <e2>) <e3>)))
;                    ------ ------------------------------------
;                    params                 body
;E2(((x <e1>) (y <e2>)) E1)

;Although there is one more cumbersome frame <exp3> all the bindings are still in tact from the perspective of <e3>.
;To avoid the extra frame, replacing the scoping out with a rearranging mechanism that instead of wrapping up the body with a procedure, simply rearranges the expressions such that definitions come first and the rest come last.
(define (rearrange body-exps)
    ;Produces ( ((u '*unassigned*) (set! u <e1>)) ((v '*unassigned*) (set! v <e2>)) ...)
    (define (define-exps body-exps)
        (cond ((null? body-exps) '())
              ((definition? (car body-exps)) (cons (car body-exps) (define-exps (cdr body-exps))))
              (else (define-exps (cdr body-exps)))))
    ;Retreives the non-definition expressions
    (define (rest-exps body-exps)
        (cond ((null? body-exps) '())
              ((definition? (car body-exps)) (rest-exps (cdr body-exps)))
              (else (cons (car body-exps) 
                          (rest-exps (cdr body-exps))))))
    (let ((define-exps (define-exps body-exps)))
        (if (null? define-exps)
            body-exps
            (append define-exps (rest-exps body-exps)))))

(define (make-procedure parameters body env)
    (list 'procedure parameters (rearrange body) env))

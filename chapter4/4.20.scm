;A)
;Inside eval
((letrec? exp) (eval (letrec->combination exp) env))

;Rest
(define (letrec? exp) (tagged-list? exp 'letrec))

(define (letrec-var-exp-seq exp) (cadr exp))
(define (letrec-body exp) (cddr exp))

(define (letrec->combination exp)
    (define (make-var-bod-seq var-exp-seq)
        (map (lambda (var-exp)
                (cons (list (car var-exp) ''*unassigned)
                      (list 'set! (car var-exp) (cadr var-exp))))
             var-exp-seq))
    (let ((seq (make-var-bod-seq (letrec-var-exp-seq exp))))
        (make-let (map car seq)
                  (sequence->exp (append (map cdr seq)
                                         (letrec-body exp))))))

;letrec->combination:
;Input:
(letrec ((even?
            (lambda (n)
              (if (= n 0)
                  true
                  (odd? (- n 1)))))
           (odd?
            (lambda (n)
              (if (= n 0)
                  false
                  (even? (- n 1))))))
    (even? 5))

;Result(indentation-done-by-me):
(let ((even? (quote *unassigned)) 
      (odd? (quote *unassigned))) 
    (begin (set! even? (lambda (n) (if (= n 0) true (odd? (- n 1))))) 
           (set! odd? (lambda (n) (if (= n 0) false (even? (- n 1))))) 
           (even? 5)))

;B)
;let-rec version(expanded):
(define (f n)
    (let ((even? (quote *unassigned)) 
          (odd? (quote *unassigned))) 
        (begin (set! even? (lambda (n) (if (= n 0) true (odd? (- n 1))))) 
               (set! odd? (lambda (n) (if (= n 0) false (even? (- n 1))))) 
               (even? n))))

;GE [primitives, f:proc-def [empty-env]]
(f 3)
;E1 [n:3 [GE]]
;E2 [even?:unassigned, odd?:unassigned [E1]]
;after: the "set!"s execute
;E2[even?:proc-def, odd?:proc-def [E1]]

;Louis's version:
(define (f n)
    (let ((even? (lambda (n) (if (= n 0) true (odd? (- n 1)))))
          (odd? (lambda (n) (if (= n 0) false (even? (- n 1))))))
        (even? n)))

;GE [primitives, f:proc-def [empty-env]]
(f 3)
;E1 [n:3 [GE]]
;E2 [even?:proc-def, odd?:proc-def, [E1]]

;Louis's approach works, but it does look loose. The odd? inside "even?"'s procedure definition and even? inside "odd?"'s both rely on the fact that they will be executed inside the outer lambda proc made by let. In other words odd? and even? aren't defined when the two inner lambda procs are evaluated. They are bound only when a new environment is created by the call to the outer lambda. So by the time odd? and even? are actually executed everything works as planned because the binding was already made. Looks loose. I'd say very astute.

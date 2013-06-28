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

(define (compile exp target linkage c-env)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage c-env))
        ((quoted? exp) (compile-quoted exp target linkage c-env))
        ((variable? exp)
         (compile-variable exp target linkage c-env))
        ((assignment? exp)
         (compile-assignment exp target linkage c-env))
        ((definition? exp)
         (compile-definition exp target linkage c-env))
        ((if? exp) (compile-if exp target linkage c-env))
        ((lambda? exp) (compile-lambda exp target linkage c-env))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage c-env))
        ((cond? exp) (compile (cond->if exp) target linkage c-env))
        ((let? exp) (compile (let->combination exp) target linkage c-env)) ;;Let compilation added
        ((application? exp)
         (compile-application exp target linkage c-env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

(define (compile-lambda-body exp proc-entry)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence (scan-out-defines (lambda-body exp)) 'val 'return)))) ;;defines are scanned out here

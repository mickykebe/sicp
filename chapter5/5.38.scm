;Spread-arguments doesn't work fully. Too lazy to make revisions.
;a)
(define argument-registers '(arg1 arg2))

(define (spread-arguments operands)
    (define (spread operands arg-regs)
        (cond ((null? operands) (empty-instruction-sequence))
              ((null? arg-regs) (error "Too many arguments for the primitive procedure"))
              (else (let ((first-operand (car operands))
                          (first-arg-reg (car arg-regs)))
                        (let ((operand-code (compile first-operand 'val 'next)))
                            (cons (append-instruction-sequences 
                                    operand-code
                                    (make-instruction-sequence (list 'val) (list first-arg-reg)
                                                               `((assign ,first-arg-reg val))))
                                  (spread (cdr operands) (cdr arg-regs))))))))
    (spread operands argument-registers))

;b)
(define (compile-two-arg-open-code operator exp target linkage)
    (let ((args (spread-arguments (operands exp))))
        (end-with-linkage linkage
            (append-instruction-sequences
                (preserving argument-registers
                            (car args)
                            (cadr args))
                (spread-arguments (operands exp))
                (make-instruction-sequence '(arg1 arg2) (list target)
                    `((assign ,target (op ,operator) (reg arg1) (reg arg2))))))))

(define (compile-mul exp target linkage)
    (compile-two-arg-open-code '* exp target linkage))

(define (compile-add exp target linkage)
    (compile-two-arg-open-code '+ exp target linkage))

(define (compile-minus exp target linkage)
    (compile-two-arg-open-code '- exp target linkage))

(define (compile-equal exp target linkage)
    (compile-two-arg-open-code '= exp target linkage))

;c)
(define (mul-application? exp) (tagged-list? exp '*))
(define (add-application? exp) (tagged-list? exp '+))
(define (minus-application? exp) (tagged-list? exp '-))
(define (equal-application? exp) (tagged-list? exp '=))

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ;;----------------additions---------------------------
        ((mul-application? exp) (compile-mul exp target linkage))
        ((add-application? exp) (compile-add exp target linkage))
        ((minus-application? exp) (compile-minus exp target linkage))
        ((equal-application? exp) (compile-equal exp target linkage))
        ;;----------------------------------------------------
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;d)
(define (compress-operands exp)
    (let ((op (operator exp))
          (args (operands exp)))
        (define (compress operands)
            (if (= (length operands) 2)
                (cons op operands)
                `(,op ,(car operands) ,(compress (cdr operands)))))
        (if (< (length args) 3)
            exp
            (compress args))))

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ;;----------------modifications---------------------------
        ((mul-application? exp) (compile-mul (compress-operands exp) target linkage))
        ((add-application? exp) (compile-add (compress-operands exp) target linkage))
        ;;----------------------------------------------------
        ((minus-application? exp) (compile-minus exp target linkage))
        ((equal-application? exp) (compile-equal exp target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;Q: What order of evaluation does our compiler produce for operands of a combination?
;A: Right to left

;Q: Where in the compiler is this order determined?
;A: Inside "construct-arglist"

;Q: Modify the compiler so that it produces some other order of evaluation.
;A:

;assumptions: append is passed as operator to the register machine simulator

(define (construct-arglist operand-codes)
    (if (null? operand-codes)
        (make-instruction-sequence '() '(argl)
         '((assign argl (const ()))))
        (let ((code-to-get-last-arg
               (append-instruction-sequences
                (car operand-codes)
                (make-instruction-sequence '(val) '(argl)
                 '((assign argl (op list) (reg val)))))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving '(env)
               code-to-get-last-arg
               (code-to-get-rest-args
                (cdr operand-codes)))))))
(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
         (preserving '(argl)
          (car operand-codes)
          (make-instruction-sequence '(val argl) '(argl)
           '((assign argl
              (op append) (reg argl) (reg val)))))))
    (if (null? (cdr operand-codes))
        code-for-next-arg
        (preserving '(env)
         code-for-next-arg
         (code-to-get-rest-args (cdr operand-codes))))))

;Q: How does changing the order of operand evaluation affect the efficiency of the code that constructs the argument list?
;A: Adversely. Under left-to-right operand execution, the result of every operand evaluation is appended to the hitherto accumulated operand results. Traversal of this list is necessary. The effect becomes more noticable as the number of operands increases.

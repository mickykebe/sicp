(define (make-operation-exp exp machine labels operations)
  (let ((op (lookup-prim (operation-exp-op exp) operations))
        (aprocs
         (map (lambda (e)
                (if (or (register-exp? e) (constant-exp? e))
                    (make-primitive-exp e machine labels)
                    (error "Label supplied as an operand" e)))
              (operation-exp-operands exp))))
    (lambda ()
      (apply op (map (lambda (p) (p)) aprocs)))))

;Test:

(define erroneous-machine
    (make-machine
        '(n)
        (list (list '= =))
        '(start
          (assign n (op =) (label start) (const 1))
          end)))

;Result
;Label supplied as an operand (label start)
;To continue, call RESTART with an option number:

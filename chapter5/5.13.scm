(define (make-machine ops controller-text)
  (let ((machine (make-new-machine)))
    ((machine 'install-operations) ops)    
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      ;------changed----------------------------------
      ;In case a register is present in the table, instead of failing returns it.
      (define (allocate-register name)  
        (let ((reg-entry (assoc name register-table)))
            (if reg-entry
                (cadr reg-entry)
                (let ((reg (make-register name)))
                    (begin (set! register-table
                                (cons (list name reg)
                                      register-table))
                           reg)))))
      ;------------------------------------------------
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (allocate-register machine name)
    ((machine 'allocate-register) name))

;Now all that's left is to change every instance of get-register inside all the execution procedures to allocate-register
(define (make-assign inst machine labels operations pc)
  (let ((target
         (allocate-register machine (assign-reg-name inst)))
        (value-exp (assign-value-exp inst)))
    (let ((value-proc
           (if (operation-exp? value-exp)
               (make-operation-exp
                value-exp machine labels operations)
               (make-primitive-exp
                (car value-exp) machine labels))))
      (lambda ()                ; execution procedure for assign
        (set-contents! target (value-proc))
        (advance-pc pc)))))

(define (make-goto inst machine labels pc)
  (let ((dest (goto-dest inst)))
    (cond ((label-exp? dest)
           (let ((insts
                  (lookup-label labels
                                (label-exp-label dest))))
             (lambda () (set-contents! pc insts))))
          ((register-exp? dest)
           (let ((reg
                  (allocate-register machine
                                     (register-exp-reg dest))))
             (lambda ()
               (set-contents! pc (get-contents reg)))))
          (else (error "Bad GOTO instruction -- ASSEMBLE"
                       inst)))))

(define (make-save inst machine stack pc)
  (let ((reg (allocate-register machine
                                (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (get-contents reg))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (allocate-register machine
                                (stack-inst-reg-name inst))))
    (lambda ()
      (set-contents! reg (pop stack))    
      (advance-pc pc))))

(define (make-primitive-exp exp machine labels)
  (cond ((constant-exp? exp)
         (let ((c (constant-exp-value exp)))
           (lambda () c)))
        ((label-exp? exp)
         (let ((insts
                (lookup-label labels
                              (label-exp-label exp))))
           (lambda () insts)))
        ((register-exp? exp)
         (let ((r (allocate-register machine
                                     (register-exp-reg exp))))
           (lambda () (get-contents r))))
        (else
         (error "Unknown expression type -- ASSEMBLE" exp))))

;Test:
(define exp-machine
  (make-machine
   (list (list '- -) (list '= =) (list '* *))
   '((assign continue (label exp-end))
     exp-start
     (test (op =) (reg n) (const 0))
     (branch (label base-case))
     (save continue)
     (save n)
     (save b)
     (assign n (op -) (reg n) (const 1))
     (assign continue (label exp-mul))
     (goto (label exp-start))
     exp-mul
     (restore b)
     (restore n)
     (restore continue)
     (assign val (op *) (reg b) (reg val))
     (goto (reg continue))
     base-case
     (assign val (const 1))
     (goto (reg continue))
     exp-end)))

;Result
;1 ]=> (set-register-contents! exp-machine 'n 3)

;Value: done

;1 ]=> (set-register-contents! exp-machine 'b 2)

;Value: done

;1 ]=> (start exp-machine)

;Value: done

;1 ]=> (get-register-contents exp-machine 'val)

;Value: 8

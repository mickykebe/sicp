;a)
    ;  .
    ;  .
    ;  .
    afterfib-n-2                         ; upon return, val contains Fib(n - 2)
       (assign n (reg val))              ; n now contains Fib(n - 2)
       (restore val)

    ;can be replaced by
    (restore n)

;b)
    (define (make-save inst machine stack pc)
        (let ((reg-name (stack-inst-reg-name inst)))
          (let ((reg (get-register machine reg-name)))
            (lambda ()
              (push stack (make-stack-entry reg-name (get-contents reg)))
              (advance-pc pc)))))

    (define (make-restore inst machine stack pc)
      (let ((reg-name (stack-inst-reg-name inst)))
          (let ((reg (get-register machine reg-name)))
            (lambda ()
              (let ((stack-entry (pop stack)))
                (if (not (eq? (stack-entry-name stack-entry) reg-name))
                    (error "Invalid restoration attempt" reg-name)
                    (begin (set-contents! reg (stack-entry-value stack-entry)) (advance-pc pc))))))))

    (define (make-stack-entry reg-name val) (cons reg-name val))
    (define (stack-entry-name stack-entry) (car stack-entry))
    (define (stack-entry-value stack-entry) (cdr stack-entry))

    ;Test:

    (define interchange-machine
                (make-machine
                    '(x y)
                    '()
                    '((assign x (const 1))
                      (assign y (const 2))
                      (save x)
                      (save y)
                      (restore x)
                      (restore y))))

;c)
;Implementation
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (the-instruction-sequence '()))
    (let ((register-table
           (list (list 'pc pc (make-stack)) (list 'flag flag (make-stack)))))
        (let ((the-ops
               (list (list 'initialize-stack
                           (lambda () (map (lambda (reg-entry) ((caddr reg-entry) 'initialize)) 
                                           register-table))))))
          (define (allocate-register name)
            (if (assoc name register-table)
                (error "Multiply defined register: " name)
                (set! register-table
                      (cons (list name (make-register name) (make-stack))
                            register-table)))
            'register-allocated)
          (define (lookup-register name)
            (let ((val (assoc name register-table)))
              (if val
                  (cadr val)
                  (error "Unknown register:" name))))
          (define (lookup-stack reg-name)
            (let ((val (assoc reg-name register-table)))
              (if val
                  (caddr val)
                  (error "Unknown register:" reg-name))))
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
                  ((eq? message 'get-stack) lookup-stack)
                  ((eq? message 'operations) the-ops)
                  (else (error "Unknown request -- MACHINE" message))))
          dispatch))))

(define (get-stack machine reg-name)
    ((machine 'get-stack) reg-name))

(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (ops (machine 'operations)))
    (for-each
     (lambda (inst)
       (set-instruction-execution-proc! 
        inst
        (make-execution-procedure
         (instruction-text inst) labels machine
         pc flag ops)))
     insts)))

(define (make-execution-procedure inst labels machine
                                  pc flag ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))

(define (make-save inst machine pc)
    (let ((reg-name (stack-inst-reg-name inst)))
      (let ((reg (get-register machine reg-name))
            (stack (get-stack machine reg-name)))
        (lambda ()
          (push stack (get-contents reg))
          (advance-pc pc)))))

(define (make-restore inst machine pc)
    (let ((reg-name (stack-inst-reg-name inst)))
      (let ((reg (get-register machine reg-name))
            (stack (get-stack machine reg-name)))
        (lambda ()
          (set-contents! reg (pop stack))
      (advance-pc pc)))))

;Test
;The simulation works if by the end the registers, "x" and "y", retained the same values they're assigned to in the beginning.
(define interchange-machine
                (make-machine
                    '(x y)
                    '()
                    '((save x)
                      (save y)
                      (restore x)
                      (restore y))))

;First let's assign the registers values
;1 ]=> (set-register-contents! interchange-machine 'x 1)

;Value: done

;1 ]=> (set-register-contents! interchange-machine 'y 2)

;Value: done

;Now let's run the simulation
;1 ]=> (start interchange-machine)

;Value: done

;Finally let's query the registers
;1 ]=> (get-register-contents interchange-machine 'x)

;Value: 1

;1 ]=> (get-register-contents interchange-machine 'y)

;Value: 2

;Success!!!

;Every change is simply a renaming of the keywords and arguably gratuitous.

;Syntax
(mov <register-name> (reg <register-name>))

(mov <register-name> (const <constant-value>))

(mov <register-name> (op <operation-name>) <input1> ... <inputn>)

(call (op <operation-name>) <input1> ... <inputn>)

(test (op <operation-name>) <input1> ... <inputn>)

(je (label <label-name>))

(jmp (label <label-name>))

(mov <register-name> (label <label-name>))

(jmp (reg <register-name>))

(push <register-name>)

(pop <register-name>)

;Implementation
(define (make-execution-procedure inst labels machine
                                  pc flag stack ops)
  (cond ((eq? (car inst) 'mov)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'je)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'jmp)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'push)
         (make-save inst machine stack pc))
        ((eq? (car inst) 'pop)
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'call)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))

;Test:
(define exp-machine
  (make-machine
   '(continue n b val)
   (list (list '- -) (list '= =) (list '* *))
   '((mov continue (label exp-end))
     exp-start
     (test (op =) (reg n) (const 0))
     (je (label base-case))
     (push continue)
     (push n)
     (push b)
     (mov n (op -) (reg n) (const 1))
     (mov continue (label exp-mul))
     (jmp (label exp-start))
     exp-mul
     (pop b)
     (pop n)
     (pop continue)
     (mov val (op *) (reg b) (reg val))
     (jmp (reg continue))
     base-case
     (mov val (const 1))
     (jmp (reg continue))
     exp-end)))

;Result
;1 ]=> (set-register-contents! exp-machine 'n 2)

;Value: done

;1 ]=> (set-register-contents! exp-machine 'b 5)

;Value: done

;1 ]=> (get-register-contents exp-machine 'val)

;Value: *unassigned*

;1 ]=> (start exp-machine)

;Value: done

;1 ]=> (get-register-contents exp-machine 'val)

;Value: 25

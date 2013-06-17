;a)
(define exp-machine
  (make-machine
   '(continue n b val)
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

;The following results were found after implementing the simulator defined in sections 5.2.1 - 5.2.3.

;(set-register-contents! exp-machine 'b 2)
;(set-register-contents! exp-machine 'n 3)
;(start exp-machine)
;(get-register-contents exp-machine 'val)

;Output = 8

;b)
(define exp-it-machine
  (make-machine
   '(b n counter product)
   (list (list '- -) (list '= =) (list '* *))
   '((assign counter (reg n))
     (assign product (const 1))
     exp-iter
     (test (op =) (reg counter) (const 0))
     (branch (label exp-end))
     (assign counter (op -) (reg counter) (const 1))
     (assign product (op *) (reg b) (reg product))
     (goto (label exp-iter))
     exp-end)))

;Results

;(set-register-contents! exp-it-machine 'b 3)
;(set-register-contents! exp-it-machine 'n 2)
;(start exp-it-machine)
;(get-register-contents exp-it-machine 'product)

;Output = 9

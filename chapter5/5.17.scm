;Now returns a pair housing the instructions as well as the labels
(define (assemble controller-text machine)
  (extract-labels controller-text
    (lambda (insts labels)
      (update-insts! insts labels machine)
      (cons labels insts))))

(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register) register-name))
              register-names)
    ((machine 'install-operations) ops)
    (let ((labels-and-insts (assemble controller-text machine)))
        ((machine 'install-labels)
         (car labels-and-insts))
        ((machine 'install-instruction-sequence)
         (cdr labels-and-insts)))
        machine))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (labels '())
        (inst-count 0)
        (tracing false))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics
                       (lambda () (stack 'print-statistics)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      ;------------added------------
      (define (preceeding-label inst-text)
        (define (pl inst-text lbls)
            (if (null? lbls)
                false
                (let ((label-entry (car lbls)))
                    (let ((label (car label-entry))
                          (insts (cdr label-entry)))
                        (if (null? insts)
                            (pl inst-text (cdr lbls))
                            (if (eq? (instruction-text (car insts)) inst-text)
                                label
                                (pl inst-text (cdr lbls))))))))
        (pl inst-text labels))
      (define (display-instruction inst-text)
        (let ((label (preceeding-label inst-text)))
            (if label
                (begin (display label) (display "\n")))
            (display inst-text)
            (display "\n")))
      ;-----------------------------
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                (if tracing
                    (display-instruction (instruction-text (car insts))))
                ((instruction-execution-proc (car insts)))
                (set! inst-count (+ inst-count 1))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'install-labels)
               (lambda (seq) (set! labels seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'inst-count-print-reset) 
               (lambda () (display inst-count) (set! inst-count 0)))
              ((eq? message 'set-tracing-status!) 
               (lambda (status) (if status (set! tracing true) (set! tracing false))))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

;Test
(define exp-machine
  (make-machine
   '(n b val continue)
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

;1 ]=> (set-tracing! exp-machine true)

;1 ]=> (start exp-machine)
;(assign continue (label exp-end))
;exp-start
;(test (op =) (reg n) (const 0))
;(branch (label base-case))
;(save continue)
;(save n)
;(save b)
;(assign n (op -) (reg n) (const 1))
;(assign continue (label exp-mul))
;(goto (label exp-start))
;exp-start
;(test (op =) (reg n) (const 0))
;(branch (label base-case))
;(save continue)
;(save n)
;(save b)
;(assign n (op -) (reg n) (const 1))
;(assign continue (label exp-mul))
;(goto (label exp-start))
;exp-start
;(test (op =) (reg n) (const 0))
;(branch (label base-case))
;(save continue)
;(save n)
;(save b)
;(assign n (op -) (reg n) (const 1))
;(assign continue (label exp-mul))
;(goto (label exp-start))
;exp-start
;(test (op =) (reg n) (const 0))
;(branch (label base-case))
;base-case
;(assign val (const 1))
;(goto (reg continue))
;exp-mul
;(restore b)
;(restore n)
;(restore continue)
;(assign val (op *) (reg b) (reg val))
;(goto (reg continue))
;exp-mul
;(restore b)
;(restore n)
;(restore continue)
;(assign val (op *) (reg b) (reg val))
;(goto (reg continue))
;exp-mul
;(restore b)
;(restore n)
;(restore continue)
;(assign val (op *) (reg b) (reg val))
;(goto (reg continue))

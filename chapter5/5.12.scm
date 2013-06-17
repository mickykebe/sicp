;Partial implementation working partially.

(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register) register-name))
              register-names)
    ((machine 'install-operations) ops)    
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    ;---------added--------
    ((machine 'build-info))
    ;----------------------
    machine))

;helper functions
(define (sorted-instructions inst-text-seq)    
    (rm-duplicates
        (sort inst-text-seq
          (lambda (t1 t2)
            (string<? (symbol->string (car t1)) 
                      (symbol->string (car t2)))))))

(define (rm-duplicates inst-text-seq)
    (define (rm-dup inst-text-seq)
        (let ((cur (car inst-text-seq)))
            (cond ((null? (cdr inst-text-seq)) inst-text-seq)
                  ((equal? cur (cadr inst-text-seq)) (rm-dup (cdr inst-text-seq)))
                  (else (cons cur (rm-dup (cdr inst-text-seq)))))))
    (if (null? inst-text-seq)
        '()
        (rm-dup inst-text-seq)))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (all-instructions '())
        (entry-point-registers '())
        (stack-registers '())
        (registers-with-sources '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))))
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
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (build-info)
        (let ((inst-text-seq (map (lambda (inst) (instruction-text inst))
                                 the-instruction-sequence)))
            (set! all-instructions (sorted-instructions inst-text-seq))))
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
              ;-----------added---------------------
              ((eq? message 'build-info) build-info)
              ((eq? message 'all-instructions) all-instructions)
              ;-------------------------------------
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (get-sorted-instructions machine)
    (machine 'all-instructions))

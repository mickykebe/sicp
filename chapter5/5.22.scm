(define append-machine
    (make-machine
        '(x y car-x new-list continue)
        (list (list 'null? null?) (list 'cons cons)
              (list 'car car) (list 'cdr cdr))
        '((assign continue (label append-end))
          append-loop
          (test (op null?) (reg x))
          (branch (label assign-y))
          (save x)
          (save continue)
          (assign x (op cdr) (reg x))
          (assign continue (label after-cdr-append))
          (goto (label append-loop))
          after-cdr-append
          (restore continue)
          (restore x)
          (assign car-x (op car) (reg x))
          (assign new-list (op cons) (reg car-x) (reg new-list))
          (goto (reg continue))
          assign-y
          (assign new-list (reg y))
          (goto (reg continue))
          append-end)))

;(set-register-contents! append-machine 'x '(a b))
;(set-register-contents! append-machine 'y '(c d))
;(start append-machine)
;(get-register-contents append-machine 'new-list)
;   (a b c d)

(define append!-machine
    (make-machine
        '(x y t last-pair continue)
        (list (list 'null? null?) (list 'cdr cdr)
              (list 'set-cdr! set-cdr!))
        '((assign continue (label append-start))
          last-pair-loop
          (assign t (op cdr) (reg x))
          (test (op null?) (reg t))
          (branch (label set-last-pair))
          (save x)
          (save continue)
          (assign x (op cdr) (reg x))
          (assign continue (label after-last-pair-loop))
          (goto (label last-pair-loop))
          after-last-pair-loop
          (restore continue)
          (restore x)
          (goto (reg continue))
          append-start
          (perform (op set-cdr!) (reg last-pair) (reg y))
          (goto (label append-end))
          set-last-pair
          (assign last-pair (reg x))
          (goto (reg continue))
          append-end)))

;(set-register-contents! append!-machine 'x '(a b))
;(set-register-contents! append!-machine 'y '(c d))
;(start append!-machine)
;(get-register-contents append!-machine 'x)
;   (a b c d)

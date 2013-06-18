(define fact-machine
    (make-machine
        '(n val continue)
        (list (list '= =) (list '- -) (list '* *) (list 'read read))
        '(input-loop
          (assign n (op read))
          (test (op =) (reg n) (const 0))
          (branch (label exit))
          (perform (op initialize-stack))
          (assign continue (label fact-done))
          fact-loop
          (test (op =) (reg n) (const 1))
          (branch (label base-case))
          (save continue)
          (save n)
          (assign n (op -) (reg n) (const 1))
          (assign continue (label after-fact))
          (goto (label fact-loop))
          after-fact
          (restore n)
          (restore continue)
          (assign val (op *) (reg n) (reg val))
          (goto (reg continue))
          base-case
          (assign val (const 1))
          (goto (reg continue))
          fact-done
          (perform (op print-stack-statistics))
          (goto (label input-loop))
          exit)))

;Results
;n=2
;(total-pushes = 2 maximum-depth = 2)
;n=3
;(total-pushes = 4 maximum-depth = 4)
;n=4
;(total-pushes = 6 maximum-depth = 6)
;n=5
;(total-pushes = 8 maximum-depth = 8)
;n=6
;(total-pushes = 10 maximum-depth = 10)

;For any n where n > 0 both the total-pushes and maximum-depth are equivalent to 2n-2.

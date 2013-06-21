;a)
(define count-leaves-machine
    (make-machine
        '(tree t count continue)
        (list (list '+ +) (list 'null? null?)
              (list 'not not) (list 'pair? pair?)
              (list 'car car) (list 'cdr cdr))
        '((assign continue (label count-leaves-done))
          count-leaves-loop
          (test (op null?) (reg tree))
          (branch (label set-count-0))
          (assign t (op pair?) (reg tree))
          (test (op not) (reg t))
          (branch (label set-count-1))
          (save continue)
          (save tree)
          (assign tree (op car) (reg tree))
          (assign continue (label after-car-count))
          (goto (label count-leaves-loop))
          after-car-count
          (restore tree)
          (save count)
          (assign tree (op cdr) (reg tree))
          (assign continue (label after-cdr-count))
          (goto (label count-leaves-loop))
          after-cdr-count
          (restore t)
          (assign count (op +) (reg t) (reg count))
          (restore continue)
          (goto (reg continue))
          set-count-1
          (assign count (const 1))
          (goto (reg continue))
          set-count-0
          (assign count (const 0))
          (goto (reg continue))
          count-leaves-done)))

;b)
(define count-leaves-iter-machine
    (make-machine
        '(tree t n continue)
        (list (list '+ +) (list 'null? null?)
              (list 'not not) (list 'pair? pair?)
              (list 'car car) (list 'cdr cdr))
        '((assign continue (label count-leaves-done))
          (assign n (const 0))
          count-leaves-loop
          (test (op null?) (reg tree))
          (branch (label null))
          (assign t (op pair?) (reg tree))
          (test (op not) (reg t))
          (branch (label set-n-1))
          (save continue)
          (save tree)
          (assign continue (label after-car-count))
          (assign tree (op car) (reg tree))
          (goto (label count-leaves-loop))
          after-car-count
          (restore tree)
          (restore continue)
          (assign tree (op cdr) (reg tree))
          (goto (label count-leaves-loop))
          null
          (goto (reg continue))
          set-n-1
          (assign n (op +) (reg n) (const 1))
          (goto (reg continue))
          count-leaves-done)))

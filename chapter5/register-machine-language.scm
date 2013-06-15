;GCD
(controller
 test-b
   (test (op =) (reg b) (const 0))
   (branch (label gcd-done))
   (assign t (op rem) (reg a) (reg b))
   (assign a (reg b))
   (assign b (reg t))
   (goto (label test-b))
 gcd-done)

;Looping GCD
(controller
  gcd-loop
    (assign a (op read))
    (assign b (op read))
  test-b
    (test (op =) (reg b) (const 0))
    (branch (label gcd-done))
    (assign t (op rem) (reg a) (reg b))
    (assign a (reg b))
    (assign b (reg t))
    (goto (label test-b))
  gcd-done
    (perform (op print) (reg a))
    (goto (label gcd-loop)))

;Subroutines
    gcd
     (test (op =) (reg b) (const 0))
     (branch (label gcd-done))
     (assign t (op rem) (reg a) (reg b))
     (assign a (reg b))
     (assign b (reg t))
     (goto (label gcd))
    gcd-done
     (goto (reg continue))
       
    ;; Before calling gcd, we assign to continue
    ;; the label to which gcd should return.
     (assign continue (label after-gcd-1))
     (goto (label gcd))
    after-gcd-1
       
    ;; Here is the second call to gcd, with a different continuation.
     (assign continue (label after-gcd-2))
     (goto (label gcd))
    after-gcd-2

;Factorial
    (controller
       (assign continue (label fact-done))     ; set up final return address
     fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       ;; Set up for the recursive call by saving n and continue.
       ;; Set up continue so that the computation will continue
       ;; at after-fact when the subroutine returns.
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label fact-loop))
     after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))   ; val now contains n(n - 1)!
       (goto (reg continue))                   ; return to caller
     base-case
       (assign val (const 1))                  ; base case: 1! = 1
       (goto (reg continue))                   ; return to caller
     fact-done)


;Fib
    (controller
       (assign continue (label fib-done))
     fib-loop
       (test (op <) (reg n) (const 2))
       (branch (label immediate-answer))
       ;; set up to compute Fib(n - 1)
       (save continue)
       (assign continue (label afterfib-n-1))
       (save n)                           ; save old value of n
       (assign n (op -) (reg n) (const 1)); clobber n to n - 1
       (goto (label fib-loop))            ; perform recursive call
     afterfib-n-1                         ; upon return, val contains Fib(n - 1)
       (restore n)
       (restore continue)
       ;; set up to compute Fib(n - 2)
       (assign n (op -) (reg n) (const 2))
       (save continue)
       (assign continue (label afterfib-n-2))
       (save val)                         ; save Fib(n - 1)
       (goto (label fib-loop))
     afterfib-n-2                         ; upon return, val contains Fib(n - 2)
       (assign n (reg val))               ; n now contains Fib(n - 2)
       (restore val)                      ; val now contains Fib(n - 1)
       (restore continue)
       (assign val                        ;  Fib(n - 1) +  Fib(n - 2)
               (op +) (reg val) (reg n)) 
       (goto (reg continue))              ; return to caller, answer is in val
     immediate-answer
       (assign val (reg n))               ; base case:  Fib(n) = n
       (goto (reg continue))
     fib-done)

(define count 0)
(define (id x)
  (set! count (+ count 1))
  x)

(define w (id (id 10)))
;;; L-Eval input:
count
;;; L-Eval value:
1
;Explanation: 
;Although it seems that id has been called twice, it hasn't.
;Analyzing the outer call to id, the expression (id 10) is passed as an argument without being evaluated.
;Inside the environment where the outer id executes, the expression (id 10) is bound to x with the form ('thunk (id 10) the-global-env). This happens because it is delayed during the call to the outer id.
;And so count is incremented only once.


;;; L-Eval input:
w
;;; L-Eval value:
10
;Explanation: 
;During the definition of w it is assigned with '(thunk (id 10) global-env). As explained earlier x is bound to the thunk of the expression (id 10) during the outer call to id, and that is what is returned.
;So when w is forced(this happens in the driver-loop where actual-value is applied to w instead of eval, which would have caused an error) the expression inside the thunk -- (id 10) -- is evaluated at which point 3 things happen.
;1) count is incremented
;2) the value of w is changed from a normal thunk to an evaluated thunk
;3) 10 is returned.

;;; L-Eval input:
count
;;; L-Eval value:
2
;Explanation:
;look above.

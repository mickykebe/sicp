(define (squarer a b)
  (multiplier a a b))

;The flaw here becomes transparent when looking at process-new-value inside the multiplier. Notice that both m1 and m2 point to the same connector a. The logic is correct when squaring a value with the above scheme. But this being a constraint system it follows that setting b's value should change a to the square root of b. Tracing through the conditions of process-new-value nowhere is the value of a(m1) set. Since both m1 and m2 refer to the same connector whose value is set to 0, the conditions inside process-new-value, which assume 3 different connectors, never evaluate to true and a remains unchanged.

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

;Q: Drawing of (memo-fib 3):

;Answer: Unless my earlier drawings have decieved you I don't have the mental fortitude to draw this.

;Q: Explain why memo-fib computes the nth Fibonacci number in a number of steps proportional to n:

;Answer: memo-fib works in O(N) time, due to the simple fact that by the time (memo-fib (- n 1)) finishes the value of (memo-fib (- n 2)) is known and stored and thus isn't evaluated. Since this is true at any moment within the iteration cycle, only one round of iteration is needed to compute values ranging from 0 to n. The rest is just lookup.

;Q: Would the scheme still work if we had simply defined memo-fib to be (memoize fib)?

;Answer: No. An environment diagram would illustrate why much clearer. But your clarity here is not my main priority, not drawing that thing is. Hence i'll go the verbose and slightly less clear, route.

; First let's consider the original definition of memo-fib. Here memo-fib is a reference to the procedure encompassed not by the Global environment but another environment under the global environment which has the table which memo-fib uses to store the previously computed results. Now every time (f x) is executed in memoize, f being the lambda expression defined inside memo-fib, a call to memo-fib(inside the else statement) is inevitably made calling memo-fib (the procedure located under the env't outlined above).

; Now let's consider the latter definition of memo-fib: (define memo-fib (memoize fib))
; Here the same call to (f x) does something else. When the execution reaches the else statement and the recursive call to either (fib (- n 1)) or (fib (- n 2)) a call is not made to memo-fib defined in the environment outlined above, but to fib which is defined in the global environment.(The same happens to any subsequent call to fib). Therefore the memoization is essentially eschewed and using memo-fib in this case is no different than using fib. In fact it's even worse because memo-fib goes to the trouble of making a table, which it never uses, before initiating computation.

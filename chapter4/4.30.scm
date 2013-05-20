(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

;a)
;Both the Text's and Cy's versions of evaluate-sequence accomplish the same thing.
;Looking at where the sequence starts(in begin):

;Text's version:
;The first expression in the sequence is:
;(proc (car items))
;"proc" here is a thunk, but since it's the operator of an application, evaluate gets the actual value before applying it.
;Everything else in the execution of this expression behaves as normal until in this case an empty object is returned.

;Cy's version:
;looking at the same expression:
;the only difference here is, after being evaluated just the same as described above, the result, still an empty object is handed to actual-value.
;And since the result of the above expression is not a thunk, but an empty object, actual-value passes it along. I.e. without forcing it.
;So both implementations do the same thing.

;b)
(define (p1 x)
  (set! x (cons x '(2)))
  x)

(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))

;(p1 1)
;If we take a look at (set! x (cons x '(2)))
;x = '(thunk 1 global-env)

;Reaching the line that evaluates '(set! x (cons x '(2))) the only difference is that it's result is passed to actual-value in Cy's version, but left by the Text's.
;The result of setting x to (cons x '(2)) returns the symbol 'ok. Even after it's passed to actual-value in Cy's version the result is still 'ok. So both implementations have the same behaviour.

;(p2 2)
;e(inside p) = '(thunk (set! x (cons x '(2))) global-env)
;In evaluating "e", the text's version does a lookup resulting in the above thunk. That's where it stops before proceeding to evaluate x.
;x remains 1 and that's what is returned in the end.
;On the other hand, in Cy's implementation what's passed into actual-value being the thunk, the expression inside it is evaluated.
;I.e. (set! x (cons x '(2)))
;thus "x" is transformed to (1 2) and that's what is returned.

;c)
;Explained in a.

;d)
;The question is whether thunks(delayed expressions) should have their expressions evaluated when they are stand-alone members of a sequence being evaluated. Cy's version works in side effect scenarios, but I don't see how anyone can rely on this feature and still maintain coherence and readability in their program. And if so this feature should be included only if the cost is negligable.
;The cost here is the amount of time taken to evaluate "thunk?" and "evaluated-thunk?". This cost appears to be minimal and so i'd say it's ok.

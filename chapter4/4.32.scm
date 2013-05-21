;Both have a different shape to start with.
;Assuming both versions represent pairs as procedures.

(cons 1 2)
;Lazier lazy lists:
;   (lambda (m) (thunk 1 global-env) (thunk 2 global-env))
;cons-stream version: (cons-stream 1 2)
;   (lambda (m) 1 (lambda () 2))

;The most obvious difference here is the execution/non-execution of the first element of the pair.
;Another point the authors touched on is the fact that "accessing the car or cdr of a lazy pair need not force the value of a list element"
;We can see in the first version that accessing the car returns a thunk. I.e. The expression in the thunk itself isn't executed until "it is really needed -- e.g., for use as the argument of a primitive, or to be printed as an answer."
;Taking advantage of this would require me to steal from the footnote and say "lazy trees".
;I can see how this extreme laziness can be leveraged to construct nodes that are delayed executions, that can possibly span forever.

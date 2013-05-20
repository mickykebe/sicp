;A procedure that accepts another before applying it, fits the bill.

(define (primality-test prime-proc n)
    (if (prime-proc n)
        (display "prime")
        (display "Not prime")))

(primality-test prime? 5)
;Jumping inside the environment where the body of primality-test is executed:
;We see that "prime-proc" is bound to (thunk prime? the-global-env).
;So when prime-proc is being applied, what is actually being applied is the thunk whose actual value -- the expression prime? -- needs to be extracted.

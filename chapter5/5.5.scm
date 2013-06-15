;Factorial

    (fact 5)
    ;Stack @ beginning
        ;Empty

    ;Stack just after branching into the base-case

    ;   ---------------------
    ;   |         2         |
    ;   ---------------------
    ;   | label: after-fact |
    ;   ---------------------
    ;   |         3         |
    ;   ---------------------
    ;   | label: after-fact |
    ;   ---------------------
    ;   |         4         |
    ;   ---------------------
    ;   | label: after-fact |
    ;   ---------------------
    ;   |         5         |
    ;   ---------------------
    ;   | label: fact-done  |
    ;   ---------------------

;Fib

(fib 4)
;Stack @ beginning
    ;Empty


    ;Stack just after branching into "immediate-answer"

    ;   -----------------------
    ;   |         2           |
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------
    ;   |         3           |
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------
    ;   |         4           |
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------

    ;Stack just after branching into "immediate-answer"(second time)

    ;   -----------------------
    ;   |         1           | <- From val
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------
    ;   |         3           |
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------
    ;   |         4           |
    ;   -----------------------
    ;   | label: afterfib-n-1 |
    ;   -----------------------

    ;       .
    ;       .
    ;       .

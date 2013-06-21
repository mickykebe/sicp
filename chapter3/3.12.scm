(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
(a b c d)
(cdr x)
;response

(b)

;Explanation

;The append procedure creates a new list with y appended to THE VALUES of x. And so x is unchanged.
; x --> [.][.]--->[.][/]
;        |         |
;       [a]       [b]
; y ---> [.][.]--->[.][/]
;   ^     |         |
;   |    [c]       [d]
;   ----------------------\
;                         |
; z ---> [.][.]--->[.][.]--
;         |         |
;        [a]       [b]

(define w (append! x y))
w
(a b c d)
(cdr x)
;response

(b c d)

;Explanation

;Here x, after append is executed, both x and w point to the same structure
;After append

; x ---> [.][.]--->[.][.] --\
;    ^    |         |       |
;    |   [a]       [b]      |
;    |                      |
; y -|-----------------------> [.][.] ---> [.][/]
;    |                          |           |
;    |                         [c]         [d]
;    |
; w -/

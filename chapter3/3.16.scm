(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

; Ah, Ben Bitdiddle. You poor old sod. If only you had the guidance of Abelson and Sussman like the rest of us.
; A prime example is z1 in the previous exercise. It only has 3 pairs and yet count-pairs produces a count of 5. The problem with the procedure is that it doesn't account for the same pairs referenced(pointed to) more than once. It sees every pair it encounters as being distinct and adds it up.

; 3 paired structure where count-pairs returns 3:

 (define z (list 'a 'b 'c))
 (count-pairs z)

;z ---> [.][.] --> [.][.] --> [.][/]
;        v          v          v
;       [a]        [b]        [c]

; 3 paired structure where count-pairs returns 4:

 (define x (list 'a 'b))
 (define z (cons x (cdr x)))
 (count-pairs z)

;z ---> [.][.]-----\
;        v         v
;x ---> [.][.]--->[.][/]
;        v         v
;       [a]       [b]

; 3 paired structure where count-pairs returns 7:

 (define x (list 'a))
 (define y (cons x x))
 (define z (cons y y))
 (count-pairs z)

;z ---> [.][.]
;        v  v
;y ---> [.][.]
;        v  v
;x ---> [.][\]
;        v
;       [a]

; 3 paired structure where count-pairs never returns:
 (define z (list 'a 'b 'c))
 (set-cdr! (last-pair x) x)
 (count-pairs z)

; z ---> [.][.]--->[.][.]--->[.][.]--\
;    ^    v         v         v      |
;    |   [a]       [b]       [c]     |
;    \                               /
;     -------------------------------

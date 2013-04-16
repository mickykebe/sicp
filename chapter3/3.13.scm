(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

; z structure

; z ---> [.][.]--->[.][.]--->[.][.]--\
;    ^    |         |         |      |
;    |   [a]       [b]       [c]     |
;    |                               /
;    \-------------------------------

(last-pair z)
; Endless loop

(define x (list 'a 'b))
(define z1 (cons x x))

;z1 ---> [.][.]
;        |  |
;        v  v
;x ---> [.][.]---> [.][/]
;        v          v
;       [a]        [b]

(define z2 (cons (list 'a 'b) (list 'a 'b)))

;z2 [.][.] ---> [.][.]--->[.][/]
;          |     v         v
;          |    [a]       [b]
;          \     ^         ^
;           ----[.][.]--->[.][/]

(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)

(set-to-wow! z1)

;Result
;((wow b) wow b)

;z1's structure after:
;z1 ---> [.][.]
;        |  |
;        v  v
;x ---> [.][.]---> [.][/]
;        v          v
;       [wow]      [b]

(set-to-wow! z2)

;Result
;((wow b) a b)

;z2's structure after
;z2 [.][.] ---> [.][.]--->[.][/]
;          |     v         v
;          |    [wow]     [b]
;          \               ^
;           ----[.][.]--->[.][/]
;                v
;               [a]

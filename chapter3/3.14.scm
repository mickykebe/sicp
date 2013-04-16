(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

; Given a list, mystery reverses it.

(define v (list 'a 'b 'c 'd))

; v's structure:

; v ---> [.][.]---> [.][.]---> [.][.]---> [.][/]
;         |          |          |          |
;        [a]        [b]        [c]        [d]

(define w (mystery v))
; w's structure

;                                         "v"
;                                          |
; w ---> [.][.]---> [.][.]---> [.][.]---> [.][/]
;         |          |          |          |
;        [d]        [c]        [b]        [a]

; The reason v points to the last element is because it only ever gets modified in the first iteration.
; That is, in the first iteration v (denoted by x) has it's cdr set to y which in the first iteration is an empty list.
; During the second iteration v, after being passed as the second argument to loop, is now y. But since y is not modified in the second loop or thereafter(it's only appended to the changing values of temp) v retains it's value assigned to it in the first iteration.

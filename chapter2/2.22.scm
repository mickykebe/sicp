(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Produces a reversed result because as the iteration moves from first to last, the next item is being appended at the front-end.
; e.g. (square-list (list 1 2 3))
; iter-1: things = (1, 2, 3) answer = nil
; iter-2: things = (2, 3) answer = (cons 1 nil)
; iter-3: things = (3) answer = (cons 4 (cons 1 nil))
; iter-4: things = () answer = (cons 9 (cons 4 (cons 1 nil)))
; Generally answer[n] = (cons (- answer 1) (answer[n-1]))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

; Doesn't work either because the list being generated won't have the shape we want
; Instead the answers would be structured as follows
; iter-1: things = (1, 2, 3) answer = nil
; iter-2: things = (2, 3) answer = (cons nil 1)
; iter-3: things = (3) answer = (cons (cons nil 1) 4)
; iter-4: things = () answer = (cons (cons (cons nil 1) 4) 9)

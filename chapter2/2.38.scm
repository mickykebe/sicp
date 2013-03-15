(define (fold-right op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence) (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right / 1 (list 1 2 3)) ;1.5
(fold-left / 1 (list 1 2 3)) ;0.167
(fold-right list nil (list 1 2 3)) ;(list 1 (list 2 (list 3 ())))
(fold-left list nil (list 1 2 3)) ;(list (list (list nil 1) 2) 3)

; The operation op has to satisfy the condition (x op y == y op x) for the results of fold-left & fold-left to be equal

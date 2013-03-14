(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) (if (pair? x) (count-leaves x) 1)) t)))

;(define (count-leaves t)
;  (accumulate (lambda (x y) (+ 1 y))  0  (enumerate-tree t)))

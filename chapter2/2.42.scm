(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board ())

(define (row? col positions)
    (let ((cur-pos (car positions)))
        (if (= (cadr cur-pos) col)
            (car cur-pos)
            (row? col (cdr positions)))))

(define (safe? k positions)
    (define (is-safe? row)
        (if (null? (cdr positions))
            #t
            (let ((cur-pos (car positions)))
                (if (or (= (car cur-pos) row) (= (cadr cur-pos) k) (= (abs (- row (car cur-pos))) (abs (- k (cadr cur-pos)))))
                    #f
                    (safe? k (cdr positions))))))
    (is-safe? (row? k positions)))

(define (adjoin-position new-row k rest-of-queens)
    (append rest-of-queens (list (list new-row k))))

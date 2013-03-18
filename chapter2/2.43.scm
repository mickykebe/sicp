(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

; The above sequence runs slowly than the one in 2.42 because while calculating queens at column k, the queens for column (k-1) is calculated (board-size) times during the process of generating an extended set of positions.

;If the previous method takes T amount of time to calculate an eight-queens puzzle, this one takes a time of (T^8!)
; (I'm not confident of this answer though. If you have a different answer, don't leave without telling me.)

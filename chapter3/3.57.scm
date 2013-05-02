(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

;With memoization in place:
;When computing fib for n=2, add-streams computes fibs for n=0 and n=1 in which case (add-streams [fib 0] [fib 1]) is memoized.
;When computing fib for n=3, add-streams computes fibs for n=1 and n=2 in which case (add-streams [fib 1] [fib 2]) is memoized.
;(But notice here that [fib 2] doesn't spawn another level of execution since it's result is memoized.)
;When computing fib for n=4, add-streams computes fibs for n=2 and n=3 in which case (add-streams [fib 2] [fib 3]) is memoized.
;(Notice again the result for [fib 2] and [fib 3] is also pre-computed)
;Therefore for any value of n, the level of computation is a linear one.

;However absent memoization and for any value of n both [fib n-1] and [fib n-2] must be thoroughly computed. Redundant and exponential computation is inevitable here.

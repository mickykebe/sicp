(define 
    (cuberoot x) 
        (cuberoot-iter 1.0 x)
)

(define 
    (cuberoot-iter guess x) 
    (if (is-good-enough guess x) 
        guess 
        (cuberoot-iter (improve-guess guess x) x)
    )
)

(define 
    (improve-guess guess x) 
    (/ (+ (/ x (square guess)) (* 2 guess)) 3)
)

(define 
    (is-good-enough guess x) 
    (< (/ (abs (- guess (improve-guess guess x))) guess) 0.001)
)

(define 
    (abs x) 
    (if (< x 0) 
        (* x -1) 
        x
    )
)

(define 
    (square x) 
    (* x x)
)

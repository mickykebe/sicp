(define (print-interval x)
    (newline)
    (display "(")
    (display (lower-bound x))
    (display " - ")
    (display (upper-bound x))
    (display ")"))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
            (make-interval (min p1 p2 p3 p4)
                           (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x (make-interval (/ 1.0 (lower-bound y)) (/ 1.0 (upper-bound y)))))

;2.8
(define (sub-interval x y)
    (let ((low (- (lower-bound x) (upper-bound y)))
          (hig (- (upper-bound x) (lower-bound y)))
          (s3 (- (upper-bound x) (lower-bound y)))
          (s4 (- (upper-bound x) (upper-bound y))))
            (make-interval (min s1 s2 s3 s4) (max s1 s2 s3 s4))))

;2.7
(define (make-interval a b) (cons a b))

(define (upper-bound interval)
    (let ((x (car interval))
          (y (cdr interval)))
          (max x y)))

(define (lower-bound interval)
    (let ((x (car interval))
          (y (cdr interval)))
          (min x y)))

;2.9
(define (width interval) (/ (- (upper-bound interval) (lower-bound interval)) 2))

;#t
(define (sum-function-abide? interval1 interval2)
    (= (width (add-interval interval1 interval2)) (+ (width interval1) (width interval2))))

;#t
(define (sub-function-abide? interval1 interval2)
    (= (width (sub-interval interval1 interval2)) (+ (width interval1) (width interval2))))

;#f
(define (mul-function-abide? interval1 interval2)
    (= (width (mul-interval interval1 interval2)) (* (width interval1) (width interval2))))

;#f
(define (div-function-abide? interval1 interval2)
    (= (width (div-interval interval1 interval2)) (/ (width interval1) (width interval2))))

;2.10
(define (span-zero? interval)
    (= (width interval) 0))

(define (div-interval x y)
    (if (span-zero? y) (error "division by 0") (mul-interval x (make-interval (/ 1.0 (lower-bound y)) (/ 1.0 (upper-bound y))))))

;2.11
(define (mul-interval x y)
    (let ((x-lo (lower-bound x))
          (x-hi (upper-bound x))
          (y-lo (lower-bound y))
          (y-hi (upper-bound y)))
      (cond ((and (positive? x-lo) (positive? x-hi) (positive? y-lo) (positive? y-hi)) 
                (make-interval (* x-lo y-lo) (* x-hi y-hi)))
            ((and (positive? x-lo) (positive? x-hi) (negative? y-lo) (positive? y-hi)) 
                (make-interval (* x-hi y-lo) (* x-hi y-hi)))
            ((and (negative? x-lo) (positive? x-hi) (positive? y-lo) (positive? y-hi)) 
                (make-interval (* x-lo y-hi) (* x-hi y-hi)))
            ((and (positive? x-lo) (positive? x-hi) (negative? y-lo) (negative? y-hi)) 
                (make-interval (* x-hi y-lo) (* x-lo y-hi)))
            ((and (negative? x-lo) (positive? x-hi) (negative? y-lo) (positive? y-hi)) 
                (make-interval (min (* x-lo y-hi) (* x-hi y-lo)) (max (* x-lo y-lo) (* x-hi y-hi))))
            ((and (negative? x-lo) (negative? x-hi) (positive? y-lo) (positive? y-hi)) 
                (make-interval (* x-lo y-hi) (* x-hi y-lo)))
            ((and (negative? x-lo) (positive? x-hi) (negative? y-lo) (negative? y-hi)) 
                (make-interval (* x-hi y-lo) (* x-lo y-lo)))
            ((and (negative? x-lo) (negative? x-hi) (negative? y-lo) (positive? y-hi)) 
                (make-interval (* x-lo y-hi) (* x-lo y-lo)))
            ((and (negative? x-lo) (negative? x-hi) (negative? y-lo) (negative? y-hi)) 
                (make-interval (* x-hi y-hi) (* x-lo y-lo))))))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

;2.12
(define (make-center-percent c p)
    (let ((width (* c (/ p 100))))
        (make-interval (- c width) (+ c width))))

(define (percent i)
    (/ (* (width i) 100) (center i)))

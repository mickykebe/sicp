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
    (let ((s1 (- (lower-bound x) (upper-bound y)))
          (s2 (- (upper-bound x) (lower-bound y)))
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

;2.13
;1 ]=> (percent (mul-interval (make-center-percent 4 1) (make-center-percent 4 2)))

;Value: 5000/1667 ~ 3

;1 ]=> (percent (mul-interval (make-center-percent 4 3) (make-center-percent 4 4)))

;Value: 17500/2503 ~ 7

;Therefore [percentage-tolerance (r1*r2) = percentage-tolerance(r1) + percentage-tolerance(r2)] for small percentages

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2) (add-interval r1 r2)))

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval one 
                      (add-interval (div-interval one r1) 
                                    (div-interval one r2)))))

;2.14
(define a (make-interval 3.92 4.08))

;Value: a

(define b (make-interval 4.95 5.05))

;Value: b

(print-interval (par1 a b))

;(2.1253012048192774 - 2.322886133032694)
;Unspecified return value

(print-interval (par2 a b))

;(2.187598647125141 - 2.256736035049288)
;Unspecified return value

;2.15

;According to wikipedia
;If an interval occurs several times in a calculation using parameters, and each occurrence is taken independently then this can
;lead to an unwanted expansion of the resulting intervals.

(define one (make-interval 1 1))

;Value: one

(center one)

;Value: 1

(center (div-interval a a))

;Value: 1.000800320128051

(center (div-interval (div-interval a a) (div-interval a a)))

;Value: 1.0032025615368196

;Therefore par2 is a better solution

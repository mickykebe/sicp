(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y)
                      (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
            (make-interval (min p1 p2 p3 p4)
                           (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x (make-interval (/ 1.0 (lower-bound y)) (/ 1.0 (upper-bound y)))))

(define (sub-interval x y)
    (let ((s1 (- (lower-bound x) (lower-bound y)))
          (s2 (- (lower-bound x) (upper-bound y)))
          (s3 (- (upper-bound x) (lower-bound y)))
          (s4 (- (upper-bound x) (upper-bound y))))
            (make-interval (min s1 s2 s3 s4) (max s1 s2 s3 s4))))

(define (make-interval a b) (cons a b))

(define (upper-bound x) (car x))

(define (lower-bound x) (cdr x))


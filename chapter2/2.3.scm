;Point constructor and selectors
(define (make-point x y)
    (cons x y))

(define (x-point pt)
    (car pt))

(define (y-point pt)
    (cdr pt))

(define (print-pt p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

;Segment constructor and selectors
(define (make-segment x-pt y-pt)
    (cons x-pt y-pt))

(define (start-segment segment)
    (car segment))

(define (end-segment segment)
    (cdr segment))

(define (midpoint-segment segment)
    (make-point (average 
                    (x-point (start-segment segment)) (x-point (end-segment segment)))
                (average 
                    (y-point (start-segment segment)) (y-point (end-segment segment)))))

;Rectangle constructor and selectors
(define (make-rect top-left-pt width height)
    (cons top-left-pt (cons width height)))

(define (width rect)
    (car (cdr rect)))

(define (height rect)
    (cdr (cdr rect)))

;Alternate constructor and selectors
(define (make-rect top-left-pt bot-right-pt)
    (cons top-left-pt bot-right-pt))

(define (top-left-pt rect)
    (car rect))

(define (bot-right-pt rect)
    (cdr rect))

(define (width rect)
    (abs (- (x-point (top-left-pt rect)) (x-point (bot-right-pt rect)))))

(define (height rect)
    (abs (- (y-point (top-left-pt rect)) (y-point (bot-right-pt rect)))))

(define (perimeter rect)
    (* 2 (+ (width rect) (height rect))))

(define (area rect)
    (* (width rect) (height rect)))

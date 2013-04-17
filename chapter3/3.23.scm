; Data structure implemented

;  [.][.]
;   |   \
;   \    ----------------------
;    \                         \
;     \                        v
;      \    -----    -----    -----
;       --->|   | -> |   | -> |   |
;(empty)  <-|   | <- |   | <- |   | ->(empty)
;           -----    -----    -----

(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (next-ptr item) (cadr item))
    (define (prev-ptr item) (cddr item))
    (define (set-next-ptr! item next) (set-car! (cdr item) next))
    (define (set-back-ptr! item prev) (set-cdr! (cdr item) prev))
    (define (empty?) (or (null? rear-ptr) (null? front-ptr)))

    (define (front)
        (if (empty?)
            (error "FRONT called with an empty deque")
            (car front-ptr)))
    (define (rear)
        (if (empty?)
            (error "REAR called with an empty deque")
            (car rear-ptr)))
    (define (front-insert! item)
        (let ((new-item (cons item (cons front-ptr '()))))
            (cond ((empty?)
                    (set-front-ptr! new-item)
                    (set-rear-ptr! new-item)
                    dispatch)
                  (else
                    (set-back-ptr! front-ptr new-item)
                    (set-front-ptr! new-item)
                    dispatch))))
    (define (rear-insert! item)
        (let ((new-item (cons item (cons '() rear-ptr))))
            (cond ((empty?)
                    (set-front-ptr! new-item)
                    (set-rear-ptr! new-item)
                    dispatch)
                  (else 
                    (set-next-ptr! rear-ptr new-item)
                    (set-rear-ptr! new-item)
                    dispatch))))
    (define (front-delete!)
        (if (empty?)
            (error "DELETE called with an empty deque")
            (begin (set-front-ptr! (next-ptr front-ptr))
                   dispatch)))
    (define (rear-delete!)
        (if (empty?)
            (error "DELETE called with an empty deque")
            (begin (set-rear-ptr! (prev-ptr rear-ptr))
                   dispatch)))
    (define (print)
        (define (iter cur)
            (display (car cur))
            (display " ")
            (if (eq? cur rear-ptr)
                (display "")
                (iter (next-ptr cur))))
        (if (empty?) 
            '() 
            (iter front-ptr)))

    (define (dispatch m) 
        (cond ((eq? m 'front) front)
              ((eq? m 'rear) rear)
              ((eq? m 'front-insert!) front-insert!)
              ((eq? m 'rear-insert!) rear-insert!)
              ((eq? m 'front-delete!) front-delete!)
              ((eq? m 'rear-delete!) rear-delete!)
              ((eq? m 'print) print)
              (else (error "Undefined Operation -- MAKE-DEQUE" m))))
    dispatch))

(define (front-deque d)
    ((d 'front)))

(define (rear-deque d)
    ((d 'rear)))

(define (front-insert-deque! d item)
    ((d 'front-insert!) item))

(define (rear-insert-deque! d item)
    ((d 'rear-insert!) item))

(define (front-delete-deque! d)
    ((d 'front-delete!)))

(define (rear-delete-deque! d)
    ((d 'rear-delete!)))

(define (print-deque d)
    ((d 'print)))


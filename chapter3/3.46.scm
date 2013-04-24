(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

;Q: Draw a timing diagram to demonstrate how the mutex implementation can fail by allowing two processes to acquire the mutex at the same time.

;A: Assuming cell is false when 2 procedures are called who share a mutex we arrive at the scene when both reach test-and-set!.

;   proc1                      proc2
;   -----------------------------
;   |                           |
;   v                           |
;   if(car cell): false         v
;   |                           if(car cell): false
;   v                           |
;   (set-car! cell true)        v
;   |                           (set-car! cell true)
;   \                           /
;    \                         /
;     \                       /
;      \                     /
;       both end up executing at the same time

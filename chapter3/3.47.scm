;a
(define (make-semaphore n)
    (let ((count 0)
          (mutex (make-mutex)))
        (define (the-semaphore m)
            (cond ((eq? m 'acquire)
                    (mutex 'acquire)
                    (if (= count n)
                        (begin (mutex 'release)
                               (the-semaphore 'acquire))
                        (begin (set! count (+ count 1))
                               (mutex 'release))))
                  ((eq? m 'release)
                    (mutex 'acquire)
                    (if (> count 0)
                        (set! count (- count 1)))
                    (mutex 'release))))
        the-semaphore))

;b
(define (make-semaphore n)
    (let ((count 0))
        (define (the-semaphore m)
            (cond ((eq? m 'acquire)
                    (if (test-and-inc! count n)
                        (the-semaphore 'acquire)))
                  ((eq? m 'release)
                    (test-and-dec! count))))
        the-semaphore))

(define (test-and-inc! val max)
  (without-interrupts
   (lambda ()
     (if (= val max)
         true
         (begin (set! val (+ val 1))
                false)))))

(define (test-and-dec! val)
    (without-interrupts
        (lambda ()
            (if (> val 0)
                (set! val (- val 1))))))

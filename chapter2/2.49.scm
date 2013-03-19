(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define origin (make-vect 0 0))

(define br (make-vect 1 0))

(define tr (make-vect 1 1))

(define tl (make-vect 0 1))

;a
(define outline-segments (list (make-segment origin br)
                               (make-segment origin tl)
                               (make-segment tl tr)
                               (make-segment tr br)))

(define outline-painter (segments->painter outline-segments))

;b
(define x-segments (list (make-segment origin tr)
                         (make-segment br tl)))

(define x-painter (segments->painter x-segments))

;c
(define diamond-segments (list (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
                               (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
                               (make-segment (make-vect 0.5 1) (make-vect 0 0.5))
                               (make-segment (make-vect 0 0.5) (make-vect 0.5 0))))

(define diamond-painter (segments->painter diamond-segments))

;d
;Too cumbersome -- almost impossible without the use of a graphics library -- to define.

;More insight on this exercise and the topic in general is available at http://wiki.drewhess.com/wiki/SICP_exercise_2.49

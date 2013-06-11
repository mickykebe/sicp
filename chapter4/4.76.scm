(define (alt-conjoin conjuncts init-frame-stream)
    (define (ac conjuncts cur-frame-stream)
      (if (empty-conjunction? conjuncts)
          cur-frame-stream
          (ac (rest-conjuncts conjuncts) 
              (stream-flatmap 
                (lambda (frame)
                    (simple-stream-flatmap
                        (lambda (frame2)
                            (let ((merge-result (merge-frames frame frame2)))
                                (if (eq? merge-result 'failed)
                                    the-empty-stream
                                    (singleton-stream merge-result))))
                        cur-frame-stream))
                (qeval (first-conjunct conjuncts) init-frame-stream)))))
    (ac conjuncts init-frame-stream))

(define (merge-frames frame1 frame2)
    (if (null? frame1)
        frame2
        (let ((var (binding-variable (car frame1)))
              (val (binding-value (car frame1))))
            (let ((extended-frame (extend-if-possible var val frame2)))
                (if (eq? extended-frame 'failed)
                    'failed
                    (merge-frames (cdr frame1) extended-frame))))))

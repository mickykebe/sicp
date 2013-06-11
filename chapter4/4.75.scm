(define (simple-stream-flatmap proc s) ;(not used here, but modified so as not to break 4.74)
  (simple-flatten 
    (lambda (s) (not (stream-null? s)))
    (stream-map proc s)))

;Answer
(define (simple-flatten filter stream)
  (stream-map stream-car
              (stream-filter filter
                             stream)))

(define (uniquely-asserted query frame-stream)
    (let ((query-pattern (car query)))
        (simple-flatten
            (lambda (s) (and (not (stream-null? s)) 
                             (stream-null? (stream-cdr s))))
            (stream-map
                (lambda (frame)
                    (find-assertions query-pattern frame))
                frame-stream))))

(put 'unique 'qeval uniquely-asserted)

;Test1:
(unique (job ?x (computer wizard)))

;Result:
;(unique (job (bitdiddle ben) (computer wizard)))

;Test2:
(and (job ?x ?j) (unique (job ?anyone ?j)))

;Result:
;(and (job (aull dewitt) (administration secretary)) (unique (job (aull dewitt) (administration secretary))))
;(and (job (cratchet robert) (accounting scrivener)) (unique (job (cratchet robert) (accounting scrivener))))
;(and (job (scrooge eben) (accounting chief accountant)) (unique (job (scrooge eben) (accounting chief accountant))))
;(and (job (warbucks oliver) (administration big wheel)) (unique (job (warbucks oliver) (administration big wheel))))
;(and (job (reasoner louis) (computer programmer trainee)) (unique (job (reasoner louis) (computer programmer trainee))))
;(and (job (tweakit lem e) (computer technician)) (unique (job (tweakit lem e) (computer technician))))
;(and (job (bitdiddle ben) (computer wizard)) (unique (job (bitdiddle ben) (computer wizard))))

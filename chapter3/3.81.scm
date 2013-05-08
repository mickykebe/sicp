;The following implementation assumes an element of a request stream has one of the two and only possible values:
;'(generate)
;'(reset [number])

(define random-init 1)

(define (rand-gen request-stream)
    (define (rand-map request n)
        (if (eq? (car request) 'reset)
            (rand-update (cadr request))
            (rand-update n)))
    (define r (cons-stream random-init 
                           (stream-map rand-map
                                       request-stream
                                       r)))
    (stream-cdr r))

;Works as long as rand-update is defined

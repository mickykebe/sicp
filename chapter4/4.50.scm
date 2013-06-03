;Inside ambeval:
((ramb? exp) (analyze-ramb exp))

;Rest:
(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (cdr exp))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (nth choices n)
        (define (loop choices i)
            (if (= n i)
                (car choices)
                (loop (cdr choices) (+ i 1))))
        (loop choices 0))
      (define (except choices n)
        (define (loop choices i)
            (if (= i n) 
                (cdr choices)
                (cons (car choices) (loop (cdr choices) (+ i 1)))))
        (loop choices 0))
      (define (try-next choices)
            (if (null? choices)
                (fail)
                (let ((i (random (length choices))))
                    ((nth choices i) env
                                     succeed
                                     (lambda ()
                                        (try-next (except choices i)))))))
      (try-next cprocs))))

;Alyssa's program can be modified as follows
(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (let ((found-word (random-element-of (cdr word-list))))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

(define (random-element-of choices)
    (require (not (null? choices)))
    (ramb (car choices) (random-element-of (cdr choices))))

;Results
;(sentence (simple-noun-phrase (article a) (noun class)) (verb lectures))
;(sentence (simple-noun-phrase (article a) (noun class)) (verb eats))
;(sentence (simple-noun-phrase (article a) (noun class)) (verb sleeps))
;(sentence (simple-noun-phrase (article a) (noun class)) (verb studies))
;(sentence (simple-noun-phrase (article a) (noun cat)) (verb lectures))
;(sentence (simple-noun-phrase (article a) (noun cat)) (verb studies))

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high)))
    (let ((j (an-integer-between i high)))
      (let ((k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

;According to the text on amb:
;"The evaluator will always initially choose the first alternative at each choice point. If a choice results in a failure, then the evaluator automagically backtracks to the most recent choice point and tries the next alternative."

;With that in mind let's look at an altered version of the procedure.
(define (a-pythagorean-triple-above low)
  (let ((i (an-integer-starting-from low)))
    (let ((j (an-integer-starting-from i)))
      (let ((k (an-integer-starting-from j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

;starting with low=1,
;Initially i=1, j=1, k=1
;since the require statement fails, the evaluator backtracks to the most recent choice, which is when k was assigned to 1 via amb.
;Now k becomes 2. We can see that there is no point when k is computed where an empty (amb) call is made. And hence while i and j always remain 1, k changes infinitely which is not what we want.

;--------------From 3.69---------------------------------------------
(define (triples s t u)
    (cons-stream (list (stream-car s)
                       (stream-car t)
                       (stream-car u))
                 (interleave (stream-map (lambda (t-u-pair)
                                            (list (stream-car s) 
                                                  (car t-u-pair) 
                                                  (cadr t-u-pair)))
                                         (stream-cdr (pairs t u)))
                             (triples (stream-cdr s)
                                      (stream-cdr t)
                                      (stream-cdr u)))))

(define int-triples (triples integers integers integers))
;--------------------------------------------------------------------

(define (pythagorean-triples)
    (let ((triple (an-element-of int-triples)))
        (require (= (+ (square (car triple))
                       (square (cadr triple)))
                    (square (caddr triple))))
        triple))

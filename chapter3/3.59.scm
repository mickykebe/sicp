;a
(define (integrate-series s)
    (stream-map / s integers))

;b
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;Show how to generate the series for sine and cosine, starting from the facts that the derivative of sine is cosine and the derivative of cosine is the negative of sine:

(define (neg-series s)
    (stream-map (lambda (x) (- x)) s))

(define cosine-series
  (cons-stream 1 (integrate-series (neg-series sine-series))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

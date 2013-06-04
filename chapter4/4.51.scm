;Inside ambeval
((permanent-assignment? exp) (analyze-permanent-assignment exp))

;Rest
(define (permanent-assignment? exp)
  (tagged-list? exp 'permanent-set!))
(define (permanent-assignment-variable exp) (cadr exp))
(define (permanent-assignment-value exp) (caddr exp))

(define (analyze-permanent-assignment exp)
    (let ((var (permanent-assignment-variable exp))
          (vproc (analyze (permanent-assignment-value exp))))
        (lambda (env succeed fail)
            (vproc env
                   (lambda (val fail2)
                        (set-variable-value! var val env)
                        (succeed 'ok fail2))
                   fail))))

;Test
(define count 0)
(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
  (permanent-set! count (+ count 1))
  (require (not (eq? x y)))
  (list x y count))
;;; Starting a new problem
;;; Amb-Eval value:
;(a b 2)
;;; Amb-Eval input:
;try-again
;;; Amb-Eval value:
;(a c 3)

;Had permanent-set! been set! count would always remain 1 at the point of display

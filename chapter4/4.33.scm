(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

;Replace the equivalent condition in eval by:
((quoted? exp) (transform-quotation exp env))

;Outside
(define (transform-quotation exp env)
    (define (transform lst)
        (if (null? lst)
            '()
            (list 'cons (list 'quote (car lst)) (transform (cdr lst)))))
    (let ((quote-content (text-of-quotation exp)))
        (if (pair? quote-content)
            (eval (transform quote-content) env)
            quote-content)))

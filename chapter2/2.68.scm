(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((equal? x (car set)) #t)
          (else (element-of-set? x (cdr set)))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
    (let ((symbol-in-tree? (element-of-set? symbol (symbols tree))))
        (cond ((not symbol-in-tree?) (error "Symbol not in tree"))
              ((and (leaf? tree) symbol-in-tree?) '())
              ((element-of-set? symbol (symbols (left-branch tree))) 
                (cons 0
                      (encode-symbol symbol 
                                     (left-branch tree))))
              ((element-of-set? symbol (symbols (right-branch tree))) 
                (cons 1
                      (encode-symbol symbol 
                                     (right-branch tree)))))))

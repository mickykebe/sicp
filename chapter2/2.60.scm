(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((equal? x (car set)) #t)
          (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
    (cons x set))

(define (union-set set1 set2)
    (append set1 set2))

(define (intersection-set set1 set2)
    (cond ((or (null? set1) (null? set2)) '())
          ((element-of-set? (car set1) set2)
                (cons (car set1) (intersection-set (cdr set1) set2)))
          (else (intersection-set (cdr set1) set2))))

;                   Duplication     Non-duplication
;element-of-set?        O(N)            O(N)
;adjoin-set             O(1)            O(N)
;union-set              O(N)            O(N^2)
;intersection-set       O(N^2)          O(N^2)

;Conditions in which to use the duplication set representation may be more desirable than the non-duplication is when the adjoin and union operations are used intensively along with the condition that the space taken by a set is not an issue.

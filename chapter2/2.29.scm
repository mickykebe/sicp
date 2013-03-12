(define (make-mobile left right)
  (list left right))

(define (make-branch len structure)
  (list len structure))

; a
(define (left-branch mobile)
    (car mobile))

(define (right-branch mobile)
    (cadr mobile))

(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (cadr branch))

; b
(define (total-weight mobile)
    (if (not (pair? mobile))
        mobile
        (let (  (mobile-left (left-branch mobile))
                (mobile-right (right-branch mobile)))
            (let (  (left-structure (branch-structure mobile-left))
                    (right-structure (branch-structure mobile-right)))
                (+  (total-weight left-structure)
                    (total-weight right-structure))))))

; c
(define (torque branch)
    (* (total-weight (branch-structure branch)) (branch-length branch)))

(define (balanced? mobile)
    (if (not (pair? mobile))
        #t
        (let (  (mobile-left (left-branch mobile))
                (mobile-right (right-branch mobile)))
            (and 
                (= (torque mobile-left) (torque mobile-right))
                (and    (balanced? (branch-structure mobile-left))
                        (balanced? (branch-structure mobile-right)))))))

; d
;(define (make-mobile left right)
;  (cons left right))
;(define (make-branch length structure)
;  (cons length structure))

; Very little, the changes to be made only apply to the selectors, in particular, "right-branch" & "branch-structure"

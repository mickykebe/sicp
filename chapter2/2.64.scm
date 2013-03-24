(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;A)
; Partial-tree takes a list and a number n, producing a binary tree with the first n elements.
; The first step taken to accomplish this, is to subdivide the first n denomination of the list into two halves, the first half ultimately forming the left branch of the tree and the second half, the right branch. 
; When the n-denomination of the list constitutes an odd number of elements the number of first half elements is equal to the number of elements found in the second half, that is, after disregarding the middle element which is used to form the root of the branch. When there is an even number of elements however, the number of elements taken for the right branch exceeds that of the left by one. Such is the calculation forming the variables left-size and right-size. 
;After this step partial-tree is called recursively for both the left and right denominations whose results, in the same order, make up the tree whose root value is taken from the middle of the list.

;N.B. The procedure also returns the denomination of the list of the elements with indexes exceeding that of n. This eliminates the need of extra iteration within the procedure when identifying the elements in the list that will occupy the right-branch.

;For the list (1 3 5 7 9 11), list->tree produces a tree with the following structure
;           5
;          / \
;         /   9 
;        1   / \
;         \  7 11  
;          3

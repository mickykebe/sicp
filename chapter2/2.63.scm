(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;a) They always give the same result. 
;   For all 3 figures in figure set 2.16 both procedures give the result (1 3 5 7 9 11)

;b)  Although the first procedure looks to have O(N) complexity the call to append, which is an O(N) procedure, at each step of iteration increases the running time. At a glance, an O(N) procedure within a procedure of O(N) iteration looks to have a complexity of O(N^2), but a closer look shows that as tree->list1 moves from one iteration to the next, the number of elements decreases by half. And such O(NlogN) is the answer.
;    Both procedures grow at a rate of O(N)

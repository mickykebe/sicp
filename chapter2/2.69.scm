(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;Answer
(define (successive-merge leaves)
    (cond ((= (length leaves) 1) (car leaves))
          (else (successive-merge 
                    (adjoin-set (make-code-tree (cadr leaves) (car leaves)) 
                                (cddr leaves))))))

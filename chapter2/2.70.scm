;(define lyric-tree (generate-huffman-tree '((a 2) (boom 1) (get 2) (job 2) (na 16) (sha 3) (yip 9) (wah 1))))

;(encode '(get a job sha na na na na na na na na get a job sha na na na na na na na na Wah yip yip yip yip yip yip yip yip yip sha boom) lyric-tree)

; Bits needed = 84
; Bits needed for fixed-length implementation = (number of characters to be encoded) * (no. of bits to encode one character)
;                                             =  36 * 3 (since there are only 8 alphabets) = 108



; In the worst case (encoding the least frequent symbol) as one proceeds from one iteration to the next the number of symbols to be searched decreases by one from a starting point of n at the beginning to only 1 at the end.
; The following calculation can be made
; (n + (n-1) + (n-2) + ... 2 + 1)
; (n + (n-1) + (n-2) + ... (n-(n-1)) + (n - n))
; (n*n (- 1 + -2 + ... + - (n-1) + -n))
; (n^2 - (n*(n+1))/2)
; (n^2 - n^2/2 - n/2)
; (n^2/2 - n/2)
; (n^2 - n)/2
; Hence the order of complexity is O(N^2)

; Although getting to the most frequent element only takes one lookup to the left of the root branch, the complexity is O(N).
; This is accounted by the fact that the symbol has to be searched in the entire list of n elements while checking its availability.

;baker    (1 2 3 4 5)
;cooper   (1 2 3 4 5)
;fletcher (1 2 3 4 5)
;miller   (1 2 3 4 5)
;smith    (1 2 3 4 5)

;Constraints:
;   1)Baker does not live on the top floor. 
;   2)Cooper does not live on the bottom floor. 
;   3)Fletcher does not live on either the top or the bottom floor.
;   4)Miller lives on a higher floor than does Cooper.
;   5)Fletcher does not live on a floor adjacent to Cooper's.

;Making a tree of the result with the constraint:               Possible Floors
;                                                             -------------------
; (Cooper, Fletcher) [After applying constraints 2, 3, 5] --> | (2, 4) or (4,2) |
;                                                             -----/--------\----          
;                                                                 /          \
;                                                                 |          |
;                                                                / \         |
;                                                               /   \        |
;                   (Miller) [After applying constraint 4]--> (3)   (5)     (5)
;                                                              |     |       |
;                                                              |    / \     / \
;                   (Baker) [After applying constraint 1]-->  (1)  (1)(3)  (1)(3)
;                                                              |    |  |    |  |
;                                               (Smith) -->   (5)  (3)(1)  (3)(1)

;There are 5 possible arrangements


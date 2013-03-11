(list 1 (list 2 (list 3 4)))

;result = (1 (2 (3 4)))

; Box
;  box|box
;   1  (pointer)
;           |
;           |
;           box|box
;            2  (pointer)
;                   |
;                   |
;                   box|box
;                    3  (pointer) -- box|box
;                                     4  (empty)



;  Tree
;   /\
;  1  \
;     /\
;    2  \
;       /\
;      3  4

; n = 5
;                          ((s5 s4 s3 s2 s1) 31)
;                            /\
;                           /  \
;                          /    \
;                       (s5 16)((s4 s3 s2 s1) 15)
;                               /\
;                              /  \
;                             /    \
;                          (s4 8)((s3 s2 s1) 7)
;                                  /\
;                                 /  \
;                                /    \                                    
;                             (s3 4)((s2 s1) 3)
;                                     /\
;                                    /  \
;                                   /    \
;                                (s2 2)(s1 1)
;

; n = 10 => The pattern builds in the same manner as the one above

; Bits required to encode the Most frequent symbol = 1
;                             Least frequent symbol = (n-1) when n >= 2
;                                                     n     when n = 1

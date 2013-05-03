;(1,1)|(1,2) (1,3) (1,4)(1,5)(1,6)
;-----------------------------
;     |(2,2)|(2,3) (2,4)(2,5)(2,6)
;     |-----|-------------------
;     |     |(3,3)|(3,4)(3,5)(3,6)(3,7)
;           |-----|--------------------
;           |     |(4,4)(4,5)(4,6)(4,7)

;For (x,y) where x=1(1,y) the formulay 2y-2 suffices.
;(1,100) = 198
;It gets more complicated when x is a higher number.
;A general observation would be:
;(1,val) appears 2 iterations apart with val exceeding the previous val by one.
;(2,val) appears 4 iterations apart with val exeeding the previous one by one.
;(3,val) >>      8 >>              >>       >>      >>              >>       .
;Formula -> I give up.

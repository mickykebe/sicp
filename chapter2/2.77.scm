; The previous call doesn't work because, the generic operation, "magnitude" only works on complex numbers distinguished by polar and rectangular tags. i.e The two tags(Types) are the only two found in the dispatch table used by the operation.

;(put 'magnitude '(complex) magnitude)

; From the perspective of procedures outside the complex number package, to obtain the magnitude of a complex number they need only work with a complex number, rather than polar or rectangular versions as the latter would require knowledge of each of the implementation mechanisms of complex numbers. The above addition simply forms a two-level system just like the make-from-real and make-from-ang procedures.


;(magnitude z) -> z-with-tags = ({complex} ({real|polar} z)
;   \/
; (apply-generic 'magnitude z-with-tags)
;    |
;    | z-with-less-tags = ({real|polar} z)
;    |
;   (apply-generic 'magnitude z-with-less-tags)
;      |
;      |
;     (Type's-operation z)

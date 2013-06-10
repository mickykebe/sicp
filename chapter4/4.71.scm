(assert! (married Minnie Mickey))

(assert! (rule (married ?x ?y)
               (married ?y ?x)))

;simple-query
(married Mickey ?who)

;disjoint
(or (job (Bitdiddle Ben) ?x)
    (married Mickey ?who))

;The delaying scheme in place, when it comes to queries culminating in infinite loops, stores the results, infinite they may be, in streams where any number of them can be accessed at any time.
;In Louis's version however, the infinite loop occurs when processing the query itself.

;Entries
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Reasoner Louis) (Hacker Alyssa P))
(supervisor (Bitdiddle Ben) (Warbucks Oliver))
(supervisor (Scrooge Eben) (Warbucks Oliver))
(supervisor (Cratchet Robert) (Scrooge Eben))
(supervisor (Aull DeWitt) (Warbucks Oliver))

(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))

;Let's look at the execution of the "and" clause.
;The first pattern (supervisor ?middle-manager ?person) matches every superivsor pattern in the data base.
;For each pattern, a frame binding ?middle-manager and ?person to their respective values is made to be used as the input frame, for the matching of the second and clause.
;Let's look at few such frames.
;One frame passed as input binds ?middle-manager to "Hacker Alyssa P" and ?person to "Bitdiddle Ben".
;So proceeding to match the second clause, "(supervisor ?x ?middle-manager)", with this frame, our only match would be a frame binding ?x to "Reasoner Louis" since ?middle-manager is already bound to Hacker Alyssa P.
;Let's look at another frame resulting from matching the first clause, namely the one binding the fifth supervisor pattern.
;Bindings of the frame, ?middle-manager: "Bitdiddle Ben", ?person: "Warbucks Oliver"
;Now matching the pattern (supervisor ?x ?middle-manager) with this frame, we will have the following 3 result frames,

;Frame1: ?x: "Hacker Alyssa P", ?middle-manager: "Bitdiddle Ben", ?person: "Warbucks Oliver"
;Frame2: ?x: "Fect Cy D", ?middle-manager: "Bitdiddle Ben", ?person: "Warbucks Oliver"
;Frame3: ?x: "Tweakit Lem E", ?middle-manager: "Bitdiddle Ben", ?person: "Warbucks Oliver"

;The output frame caused by using the input frame resulting from matching (supervisor (Scrooge Eben) (Warbucks Oliver)), is:

;Frame: ?x: "Cratchet Robert", ?middle-manager: "Scrooge Eben", ?person: "Warbucks Oliver"

;And so we have four frames where ?person is bound to "Warbucks Oliver"

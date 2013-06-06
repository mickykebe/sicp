(address (Scrooge Eben) (Weston (Shady Lane) 10))
(job (Scrooge Eben) (accounting chief accountant))
(salary (Scrooge Eben) 75000)
(supervisor (Scrooge Eben) (Warbucks Oliver))
(can-do-job (computer wizard) (computer programmer))

;Answer:
(rule (replacable-with ?person1 ?person2)
    (and (or (job ?person1 ?position1)
             (and (job ?person2 ?position2) (can-do-job ?position1 ?position2))
         (not (same ?person1 ?person2))))

;a)
(replacable-with ?x (Fect Cy D))

;b)
(and (replacable-with ?person1 ?person2)
     (salary ?person1 ?salary1)
     (salary ?person2 ?salary2)
     (lisp-value > ?salary2 ?salary1))

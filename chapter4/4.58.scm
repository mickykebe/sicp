(rule (big-shot ?person)
    (and (job ?person (?division . ?position1))
         (supervisor ?person ?spisor)
         (not (job ?spisor (?division . ?position2)))))

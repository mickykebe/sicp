;The answer is unaffected. The order however, depends on the implementation and so it is with discomfort I answer, filling the gaps left by the current unavailability of the implementation with reasoned conjecture.

;So the real answer, whether confirmation or a profound change, is pending after review of section 4.3.3

;The ordering could affect the efficiency. The extent of my understanding of amb evaluation is:
;At any non-deterministic choice point the current snapshot of "amb values", that is all the current values assigned to the five people, is checked against the entire set of restrictions one at a time.
;The order in which the restrictions are checked against the snapshot is where I can see the order of definition having an impact. 
;If for instance the restriction defined last is checked first, having the restriction that fails against most of the snapshots should be defined last. If it's the other way around the reverse should happen.

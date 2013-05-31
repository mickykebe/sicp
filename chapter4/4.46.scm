;The problem I think is infinite recursion. If we take our usage of amb in parse-verb(parse-noun works just the same), i.e. 
(amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))

;Evaluating operands from last to first, in this instance invokes a recursive call to maybe-extend in which this amb statement is found. Thus in trying to access the last value of amb the evaluator dips into a loop that never returns.


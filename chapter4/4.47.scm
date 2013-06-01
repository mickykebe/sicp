(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))

;It works.
;Asssuming operands to amb are evaluated from first to last, the first operand would change to the list that invokes a recursive call which results in an indefinite loop.

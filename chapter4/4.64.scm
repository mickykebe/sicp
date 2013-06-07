;previous
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))

;current
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person ?middle-manager))))

;In the first implementation, there will always be a point in the evaluation of the first pattern of the and clause, the resulting frame/s serving as input for the second pattern in the and clause, where it returns an empty frame, terminating evaluation.
;In other words, when the pattern "(supervisor ?staff-person ?middle-manager)" returns an empty frame, evaluation won't proceed to "(outranked-by ?middle-manager ?boss)".

;However, this is not the case in the second implementation. Here the patterns in "and" are reversed and so outranked-by is the first to be recursively applied to unbound variables guaranteeing an endless loop.

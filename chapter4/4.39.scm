;The answer is unaffected. The efficiency however, depends on the implementation and so it is with discomfort I answer, filling the gaps left by the current unavailability of the implementation with reasoned conjecture.

;The ordering could affect the efficiency. The extent of my understanding of amb evaluation is:
;At any non-deterministic choice point the current snapshot of "amb values", that is all the current values assigned to the five people, is checked against the entire set of restrictions one at a time.
;The order in which the restrictions are checked against the snapshot is where I can see the order of definition having an impact. 
;The restriction defined first being checked first, having the restriction that fails against most of the snapshots defined first could be one crucial consideration. To elaborate:

;If for instance there were four restrictions with the probablity of the first 3 passing at any point being equally high, in contrast to the fourth restriction with a very high probability of failure, having the fourth restriction defined last will be less efficient because for most of the check points that pass on the 3 restrictions and fail on the fourth the evaluator would be unnecessarily checking the first three.

;However this consideration assumes all restrictions have the same running time. This observation brings us to another consideration which is the execution time of the restrictions. Taking the above scenario with the 4 restrictions, if we were suddenly told the probablities of success/failure of the 4 restrictions were more or less even, but added to that the knowledge of the execution time of the fourth restriction being considerably longer than the 3 combined, then we'd have to put the 4th restriction last. In this scenario having the 4th restriction as the first one checked makes no sense since it takes longer and especially because the probability of success is no better than the others.

;Balancing the two considerations is the key issue here.
;The first restriction in the procedure which checks for distinctness is a prime example.
;At first glance it seems that it's properly placed since it's the restriction that has a high probability of failure. However the procedure distinct? probably takes O-N-Square time to compute, and hence in comparison to the other restrictions which all take O(1), it's probably best to put it last.

;When dealing with queries whose execution results in infinite streams such interleaving makes sense.
;For instance evaluating an "or" clause with two patterns, the first under evaluation culminating in an infinite stream of results and the second having a fixed number of result frames, appending the two streams, in the given order, would have been impossible.
;Interleaving is the ideal solution for this scenario because despite the infinite nature of the first stream, we can now observe the evaluation results of both clauses. The same applies to stream-map.

;If for example we look at the use of stream-map in the processing of a simple query with more than one input-frames, without the delay in flatten-stream the query would be processed with respect to every frame at execution time. Currently however the query is evaluated only against the first frame, with the evaluation and stream-mapping with the rest of the frames staying a promise.

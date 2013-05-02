;Louis Reasoner asks why the sqrt-stream procedure was not written in the following more straightforward way, without the local variable guesses:
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))

;To understand why let's look at the original definition:
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)
;Let's step into the following execution:
(sqrt-stream 2)
;Returns guesses which is equal to(not literally):
;(cons-stream 1.0 (stream-map improve-proc guesses))
;Now the cdr part of guess isn't executed, but packaged via delay to be forced later.
;Let's zoom in on this packaging.
;-----------------------------------------------
;| already-run?: false, result:false           |
;-----------------------------------------------
;  |(lambda ()                          |
;  |  (if (not already-run?)            |        \
;  |    (begin (set! result ([OUR_CDR]))|-------- \  \/
;  |           (set! already-run? true) |-------- /  /\
;  |                result)             |        /
;  |         result))                   |
;  --------------------------------------
;What's returned after the packaging is the lambda procedure in the box below. (The two variables act as global variables from the perspective of this procedure). Let's call this procedure X for easier reference.
;Let's proceed.
;Now let's see what happens when executing (stream-cdr guesses)
;X is executed("forced"). We reach [OUR-CDR] which is equal to (stream-map improve-proc guesses).
;What happens here is crucial.
;Expanding guesses we get:
;(stream-map improve-proc (cons-stream 1.0 X))
;Notice here the cdr of expanding guesses is the lambda expression above and not a new call to delay with the expression "(stream-map improve-proc guesses)" that results in a new delayed lambda expression like the one above. (This distinction is where the answer is).
;Now we can execute stream-map.
;We get the following result.
;(cons-stream (improve-proc 1.0) (stream-map improve-proc X)) --> Never forget X is the lambda proc.
;(cons-stream 1.5 (stream-map improve-proc X))
;Now before I make the mind-blowing-aha-prompting-illumination let's make one more redundant observation.
;The cdr of the result we now have (stream-map improve-proc X) isn't executed. Just as the cdr of guesses was not executed when we defined it, this cdr goes through the same process of being packaged into a separate lambda procedure.(I won't draw another figure. It's basically the same). Let's call this procedure Y.
;Let's rewrite our answer accordingly.
;(cons-stream 1.5 Y)

;Now for the illumination. Let's get back to what happened when we first executed (stream-cdr guesses).
;We went into X. What we've been doing so far, in case you've forgotten, since after starting executing X is computing [OUR_CDR](cdr of guesses).
;So now that we have our answer, we set "result" in X with (cons-stream 1.5 Y) and "already-run?" to true and return "result".

;To put everything together let's consider (stream-cdr (stream-cdr guesses)).
;This is the same as (stream-cdr (cons-stream 1.5 Y)) or (stream-cdr (cons-stream 1.5 (stream-map improve-proc X)))
;Notice that the process spawned here is exactly the same as the one engendered when we computed (stream-cdr guesses). This is only possible because when we reach X we're accessing the memoized result instead of going through the previous process once again.


;Coming to the answer. In the alternate procedure memoization doesn't take place. The breakdown occurs after calling (stream-cdr (sqrt-stream 2)). X or the lambda procedure is built when sqrt-stream is called, but the call to stream-map instead of referring to x is another call to stream-map forgoing any memoization.(going through the process gives a better visualization)

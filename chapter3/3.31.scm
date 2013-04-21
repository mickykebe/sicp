(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(probe ’sum sum)
;sum 0 New-value = 0
(probe ’carry carry)
;carry 0 New-value = 0
(half-adder input-1 input-2 sum carry)
;ok
(set-signal! input-1 1)
;done
(propagate)
;sum 8 New-value = 1
;done
(set-signal! input-2 1)
;done
(propagate)
;carry 11 New-value = 1
;sum 16 New-value = 0
;done

;Q: The internal procedure accept-action-procedure! defined in make-wire specifies that when a new action procedure is added to a wire, the procedure is immediately run. Explain why this initialization is necessary.

;The call to the action procedure, which is a call to after-delay, is what registers the real-action (procedure defined inside the call to after delay) inside the agenda.

;agenda-entries
;During call to half-adder
;at (+ (current-time agenda) or-gatedelay) execute (set-signal! d (logical-or input-1 input-2))
;at (+ (current-time agenda) or-gate-delay) execute (set-signal! d (logical-or input-1 input-2))
;at (+ (current-time agenda) and-gatedelay) execute (set-signal! c (logical-and input-1 input-2))
;at (+ (current-time agenda) and-gatedelay) execute (set-signal! c (logical-and input-1 input-2))
;at (+ (current-time agenda) inverter-delay) execute (set-signal! e (logical-not c))
;at (+ (current-time agenda) and-gatedelay) execute (set-signal! s (logical-and d e))
;at (+ (current-time agenda) and-gatedelay) execute (set-signal! s (logical-and d e))

;A call to propagate after a call to half-adder wouldn't have worked, were it not for the initialization, because the agenda would have been empty.

;During call to (set-signal! input-1 1)
;agenda entries
;spawned by: change to input-1. entry: (+ (current-time agenda) or-gate-delay) execute (set-signal! d (logical-or input-1 input-2))
;spawned by: change to d. entry: (+ (current-time agenda) and-gatedelay) execute (set-signal! s (logical-and d e))
;spawned by: change to input-1. entry:(+ (current-time agenda) and-gatedelay) execute (set-signal! c (logical-and input-1 input-2))
;spawned by: change to c. entry: (+ (current-time agenda) inverter-delay) execute (set-signal! e (logical-not c))
;spawned by: change to e. entry: (+ (current-time agenda) and-gatedelay) execute (set-signal! s (logical-and d e))

;Propagate executes all the entries one after the other.

;Entries made by the call to (set-signal! input-2 1) is similar to the same call affecting input-1.

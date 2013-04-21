;Queue implementation

(define a (make-wire))
(define b (make-wire))
(define c (make-wire))

(set-signal! b 1)

(and-gate a b c)

;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])))

(set-signal! a 1)

;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])), (lambda () (set-signal! c 1[and-value-of-a&b])))

(set-signal! b 0)

;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])), (lambda () (set-signal! c 1[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])))

(propagate)
;executes the actions in the first-segment from first to last. I.e in the same order the actions were specified.

;List implementation
;(Adding and removing procedures only at the front)

(set-signal! b 1)

(and-gate a b c)

;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])))

(set-signal! a 1)
;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 1[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])), (lambda () (set-signal! c 0[and-value-of-a&b])))

(set-signal! b 0)

;agenda entries
;first-segment: seg-time: 3, seg-queue: ((lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 1[and-value-of-a&b])), (lambda () (set-signal! c 0[and-value-of-a&b])),  (lambda () (set-signal! c 0[and-value-of-a&b])))

(propagate)
;Although it executes the actions in the first-segment from first to last, notice it works opposite to the intended order.

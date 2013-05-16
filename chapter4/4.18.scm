(define (p a)
    (define x <e1>)
    (define y <e2>)
    <e3>)
;GE = ((primitives (p, ('procedure <p-params> <scoped-out-body>))) empty-env)
(p 3)
;E1 = (((a,3)) GE)
;E2 = (((x, '*unassigned*) (y, '*unassigned*)) E1)
;E3 = (((a, <e1>) (b, <e2>)) E2)
;when the "set!"s are executed x & y in E2 are changed to <e1> & <e2>

;This scheme fails in computing the following procedure
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;When building E3, a and b are bound to the evaluations of the expressions of y and dy respectively. Specifically (integral (delay dy) y0 dt) and (stream-map f y).
;The problem occurs when binding b with the evaluation of (stream-map f y). Since y is still bound to '*unassigned* we're result with an error of trying to access an unassigned var.
;The problem doesn't occur when a is bound, because dy isn't evaluated since it's encompassed by delay.

;The problem doesn't persist in the previous scheme of scanning out definitions because the stream-map evaluation is done after y is bound.

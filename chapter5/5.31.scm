;1 - saving and restoring the env register around the evaluation of the operator
;2 - saving and restoring env around the evaluation of each operand (except the final one)
;3 - saving and restoring argl around the evaluation of each operand
;4 - saving and restoring proc around the evaluation of the operand sequence

;a) (f 'x 'y) => Superfluous operations: 1, 2, 3, 4
;b) ((f) 'x 'y) => Superfluous operations: 1, 2, 3, 4

;   It might seem that 1 is necessary here, but notice that the call to f recieved no arguments.
;   Although an environment extension practically takes place when evaluating f(if it's a compound procedure), the environment is still the same as was in the beginning because no variables are bound.

;c) (f (g 'x) y) => Superfluous operations: 1

;   2 is needed here in case procedure g's parameter to which 'x is bound to is named y. 
;   In such a case by the time we get to evaluating y, we'll get the value 'x as the environment we're working with is the one to which y is bound to 'x while evaluating (g 'x).
;   What we wanted was, y's value in the parent environment.

;d) (f (g 'x) 'y) => Superfluous operations: 1, 2

;   The above consideration is invalid here since we're dealing with a constant as the second argument. 2 is superfluous.

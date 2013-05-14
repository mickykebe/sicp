;A call to (map (lambda (x) (+ x 2)) '(1 2)) is made:
;Louis's version(map defined as a primitive using the system's map):
;Inside apply-primitive-procedure:
;(apply (system's map) args)
;But here args is the list '(procedure (x) ((1 2))) content-of-env). The system's map is not expecting a gutted version but a normal proc or a lambda expression.

;Eva defined map as a compound procedure inside the "ME". It works as expected. (too lazy to trace through it)

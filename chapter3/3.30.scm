;(full-adder a b c-in sum c-out)

(define (ripple-carry-adder a-bits b-bits sum-bits carry)
    (define (iter a-wires b-wires sum-wires c)
        (if (null? a-wires)
            'ok
            (begin (full-adder (car a-wires) (car b-wires) (car sum-wires) carry)
                   (iter (cdr a-wires) (cdr b-wires) (cdr sum-wires) carry))))
    (iter a-bits b-bits sum-bits 0))

;Q: What is the delay needed to obtain the complete output from an n -bit ripple-carry adder, expressed in terms of the delays for and-gates, or-gates, and inverters?

;A: n*(time-delay-of-a-full-adder)
;   n*(2*(time-delay-of-a-half-adder) + or-gate-delay)
;   n*(2*(2*and-gate-delay + or-gate-delay + inverter-delay) + or-gate-delay)
;   n*(4*and-gate-delay + 2*or-gate-delay + 2*inverter-delay + or-gate-delay)
;   4*n*and-gate-delay + 3*n*or-gate-delay + 2*n*inverter-delay

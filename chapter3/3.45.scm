(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

;Let's trace through a call to serialized-exchange by viewing the changes the 2 serialization sets undergo:

(serialized-exchange acc1 acc2)

;Inside serialized-exchange
(serializer1 (serializer2 exchange))    ;serializer2 [exchange], serializer1 [serialized-exchange]

;Inside exchange
(account1 'withdraw)                    ;serializer2 [exchange], serializer1 [serialized-exchange, acc1-withdraw]
((account1 'withdraw) difference)       ; This call which is equal to (acc1-withdraw difference) fails to execute b/c it belongs to serialization1 which also houses it's caller. (never finishes)

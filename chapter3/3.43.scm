(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

;account1 = 10, account2 = 20, account3 = 30

;1)Argue that if the processes are run sequentially, after any number of concurrent exchanges, the account balances should be $10, $20, and $30 in some order.

;Argument:
; Although the placement of the values is impossible to determine after an arbitrary number of exchanges it follows that any number of exchanges shorn of interleaving will result in the same values as were in the beginning.
;Example:
(exchange account1 account3)
(exchange account1 account2)
(exchange account2 account2)
(exchange account3 account2)
;The above lines executed sequentially, result in the following sequence of events.
;account1 = 30, account2 = 20, account3 = 10
;account1 = 20, account2 = 30, account3 = 10
;account1 = 20, account2 = 30, account3 = 10
;account1 = 20, account2 = 10, account3 = 30
;The values remain the same, despite changes in the ordering. The same can be demonstrated with any number of exchanges.

;2)Draw a timing diagram to show how this condition can be violated if the exchanges are implemented using the first version of exchange.

;Argument:
;Considering the following calls executed in parallel a possible effect:

(exchange account1 account2) ;Done by peter
(exchange account1 account3) ;Done by paul

;   Peter                           Paul
;   -------------------------------------
;   |                                   |
;   v                                   |
;   difference: 10-20=-10               v
;   |                                   difference: 10-30=-20
;   v                                   |
;   account1(after -10 withdrawal): 20  |
;   |                                   |
;   v                                   |
;   account2(after -10 deposit): 10     |
;                                       v
;                                       account1(after -20 withdrawal): 40
;                                       |
;                                       v
;                                       account3(after -20 deposit): 10
;The violation has been demonstrated with account1's balance changing to 40.

;3)On the other hand, argue that even with this exchange program, the sum of the balances in the accounts will be preserved.

;Argument:
;As long as the transactions on individual accounts remain serialized, no amount of interleaving in this context will affect the sum because any withdrawal on an account is always counteracted by a deposit of the same value. The unserialization of exchange disrupts the balances to the extent where some are higher and some lower than they should be. But it doesn't malfunction to the extent of adding or subtracting an amount to the final sum of the balances because anything it takes away it always puts back. It's only mistake is that it does it to an unbalanced outcome which is still no less erroneous.

;4) Draw a timing diagram to show how even this condition would be violated if we did not serialize the transactions on individual accounts.

(exchange account1 account2) ;Done by peter
(exchange account1 account3) ;Done by paul

;To make things easier i'll use (set! balance (- balance difference)) & (set! balance (+ balance difference)) instead of withdraw and deposit respectively.

;   Peter                           Paul
;   -------------------------------------
;   |                                   |
;   v                                   |
;   difference: 10-20=-10               v
;   |                                   difference: 10-30=-20
;   v                                   |
;   (account1) access balance:10        |
;   |                                   |
;   v                                   |
;   (account1) new value: 10-(-10)=20   v
;   |                                   (account1) access balance: 10
;   |                                   |
;   |                                   v
;   v                                   (account1) new value: 10-(-20)=30
;   (account1) set-balance! = 20        |
;   |                                   v
;   v                                   (account1) set-balance! = 30
;   (account2) access balance:20        |
;   |                                   |
;   v                                   |
;   (account2) new value: 20+(-10)=10   |
;   |                                   |
;   v                                   |
;   (account2) set-balance! = 10        v
;                                       (account3) access balance: 30
;                                       |
;                                       v
;                                       (account3) new value: 30+(-20)=10
;                                       |
;                                       v
;                                       (account3) set-balance! = 10
;Final result: account1 = 30, account2 = 10, account3 = 10
;Sum=50

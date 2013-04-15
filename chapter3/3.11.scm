(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

;Environment structure for (define acc (make-account 50))


;Global_Env  --------------------------------------------------------------------
;            | make_account: ---                                                |
;            | acc:---         |                                                |
;            --------|-----------------------------------------------------------
;                    |         |  ^                                  ^
;                    |         |  |                          E1 -----|---------- <-------------   
;                    |        (.)(.)                            | balance: 50  |              |
;                    |        params: balance                   | withdraw: --------------(.)(.)
;                    |        body: body-of-make-account        | deposit: ... |         params: amount
;                    |                                          | dispatch: ...|         body: body-of-withdraw
;                    |                                          ----------------     
;                    |                                              ^
;                    |                                              |
;                    ------------------------->(.)(.)----------------
;                                              params: m
;                                              body: body-of-dispatch

; Environment structure for ((acc 'deposit) 40)


;Global_Env  --------------------------------------------------------------------
;            | make_account: ---                                                |
;            | acc:---         |                                                |
;            --------|-----------------------------------------------------------
;                    |         |  ^                                  ^
;                    |         |  |                          E1 -----|---------- <-----------------------------
;                    |        (.)(.)                            | balance: 50  |                              |
;                    |        params: balance                   | withdraw: ----------------------------->(.)(.)
;                    |        body: body-of-make-account        | deposit: ... |                         params: amount
;                    |                                          | dispatch: ...|                         body: body-of-withdraw
;                    |                                          ---------------- <----------------
;                    |                                              ^         ^                  |
;                    |                                              |     E2 --------------   E3 --------------
;                    ------------------------->(.)(.)----------------        | m: deposit |      | amount: 40 |
;                                              params: m                     --------------      --------------
;                                              body: body-of-dispatch        (call to dispatch)   (call to deposit)


; The other 2: ((acc 'withdraw) 60) & (define acc2 (make-account 100)) are have similar structures to the ones above respectively and will be ignored.

; As to the questions they can be easily deduced from the diagrams and a few seconds of rumination and so will also be ignored. (I really don't want to draw the other 2 diagrams :) )

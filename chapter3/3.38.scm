; Account: 100

;Concurrent executions:
;Peter:	(set! balance (+ balance 10))
;Paul:	(set! balance (- balance 20))
;Mary:	(set! balance (- balance (/ balance 2)))

;Q: List all the different possible values for balance after these three transactions have been completed, assuming that the banking system forces the three processes to run sequentially in some order.

;A:

;1) Peter -> Paul -> Mary = 45
;2) Peter -> Mary -> Paul = 55
;3) Paul -> Peter -> Mary = 45
;4) Paul -> Mary -> Peter = 50
;5) Mary -> Peter -> Paul = 40
;6) Mary -> Paul -> Peter = 40
; Possible values: 40, 45, 50, 55

;Q: List all the different possible values for balance after these three transactions have been completed, assuming that the banking system forces the three processes to run sequentially in some order.


;A: One possible outcome:
;       1) 110
;      Peter    Bank       Paul       Mary
;               100
;                |
;        ---------------------------------------------
;       |                     |                      |
;       v                     |                      |
; access balance: 100         v                      |
;       |                  access balance: 100       v
;       |                     |                    access balance: 100
;       |                     |                      |
;       |                     |                      v
;       |                     v                    new value: 100/2 = 50
;       v                  new value: 100-20 = 80    |
; new value: 100+10 = 110     |                      |
;       |                     v                      |
;       |                  set-balance! = 80         |
;       |                                            v
;       v                                          set-balance! = 50
; set-balance! = 110

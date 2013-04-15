;Initial function
(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

;Function without makeup (before of the before/after :p )

(define (make-withdraw initial-amount)
    ((lambda (balance)
        (lambda (amount)
          (if (>= balance amount)
              (begin (set! balance (- balance amount))
                     balance)
              "Insufficient funds"))) initial-amount))

;Demonstrating the environment for (define W1 (make-withdraw 100)) is enough.

           
;             _________________________________________________________________________________________
;            |make-withdraw:-----                                                                      |
;Global_Env  |                  ||                                                                     |
;            |W1:------------------------------------------------------------                          |
;            |______________________________________________________________||_________________________|
;                               ||   ^                                      ||                    ^
;                              \  /  |                                      ||                    |
;                               \/   |                                      ||             ---------------------
;                             (.)(.)--                                      ||      E1 --->|initial-amount: 100|
;                              |                                            ||             ---------------------
;                          param: initial-amount                            ||                    ^
;                          body: ((lambda (balance)                         ||                    | 
;                                    (lambda (amount)                       ||             --------------
;                                      (if (>= balance amount)              ||      E2 --->|balance: 100|
;                                          (begin (set! balance (- balance amount))        --------------
;                                                 balance)                  ||                    ^
;                                          "Insufficient funds"))) initial-amount))               |
;                                                                          \  /                   |
;                                                                           \/                    |
;                                                                         (.)(.)-------------------
;                                                                          |
;                                                                      param: amount
;                                                                      body: (if (>= balance amount)
;                                                                                (begin (set! balance (- balance amount))
;                                                                                       balance)
;                                                                                "Insufficient funds")

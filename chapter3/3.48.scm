;Q:Explain in detail why the deadlock-avoidance method described above, (i.e., the accounts are numbered, and each process attempts to acquire the smaller-numbered account first) avoids deadlock in the exchange problem.

;A:Instead of observing changes to serialization sets, a mutex perspective serves a better visual guide.
;  First let's consider a call to serialized-exchange where a deadlock, although not inevitable, happens to occur.
;  parallel execution of (serialized-exchange acc1 acc2) & (serialized-exchange acc2 acc1)

;  Taking "serializer1" as the serializer for "acc1" and "serializer2" as the serializer for "acc2" let's expand the above 2 calls as:
;  (serializer1 (serializer2 exchange)) & (serializer2 (serializer1 exchange))
;  From a mutex perspective the call on the left produces the procedure defintion
;  (define (...)
;     (mutex-2 'acquire)
;       (execute
;            (define (...)
;               (mutex-1 'acquire)
;               (execute exchange)
;               (mutex-1 'release)
;            )
;       )
;     (mutex-2 'release)
;   )

; And the call to the right begets:
;  (define (...)
;     (mutex-1 'acquire)
;       (execute
;            (define (...)
;               (mutex-2 'acquire)
;               (execute exchange)
;               (mutex-2 'release)
;            )
;       )
;     (mutex-1 'release)
;   )

; What happens next is both these procedures are called with acc1 & acc2 as their arguments.
; If execution follows the following sequence of events we reach a deadlock
; (mutex-2 'acquire)[1st proc] -> (mutex-1 'acquire)[2nd proc] -> (a call to acquire any of the 2 mutexes)

; Coming back to the question:
; A scheme where each account had a unique number value with which any serialization is done so in increasing order transforms the above 2 procedures into the same procedure with mutexe's appearing in decreasing order with respect to their parent account's number. Hence in the above scenario, if acc1 has a smaller number than acc2, the first procedure will take hold to calls of serialized-exchange regardless of the order of acc1 and acc2 whereby avoiding the possibility of a deadlock.

;The implementation:
(define (init-account-system)
    (let ((n 0)
          (mutex (make-mutex)))
        (define (make-account-and-serializer balance)
          (define num 0)
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
              (cond ((eq? m 'account-number?) num)
                    ((eq? m 'withdraw) withdraw)
                    ((eq? m 'deposit) deposit)
                    ((eq? m 'balance) balance)
                    ((eq? m 'serializer) balance-serializer)
                    (else (error "Unknown request -- MAKE-ACCOUNT"
                                 m))))
            (mutex 'acquire)
            (set! n (+ n 1))
            (set! num n)
            (mutex 'release)
            dispatch))
         make-account-and-serializer))

(define make-account-serializer-proxy (init-account-system))

(define (make-account-and-serializer balance)
    (make-account-serializer-proxy balance))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    (if (< (account1 'account-number?) (account2 'account-number?))
        ((serializer2 (serializer1 exchange)) account1 account2)
        ((serializer1 (serializer2 exchange)) account1 account2))))

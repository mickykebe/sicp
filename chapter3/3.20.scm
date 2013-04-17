(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)
(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value)
  z)
(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value)
  z)

;car, cdr, set-car!, set-cdr! are all bound to their procedures in the global environment Global_Env.(not included in the diagrams)

;Environment structure of (define x (cons 1 2)):

;Global_Env  --------------------------------------------------------------------
;            | cons: ----------\                                                |
;            | x:----\         |                                                |
;            --------|-----------------------------------------------------------
;                    |         |  ^                                  ^
;                    |         |  |                          E1 -----|---------- <-------------   
;                    |        (.)(.)                            | x: 1, y: 2   |              |
;                    |        params: x, y                      | set-x: -----------------(.)(.)
;                    |        body: body-of-cons                | set-y: ...   |         params: v
;                    |                                          | dispatch: ...|         body: body-of-set-x
;                    |                                          ----------------     
;                    |                                              ^
;                    |                                              |
;                    ------------------------->(.)(.)----------------
;                                              params: m
;                                              body: body-of-dispatch


(define z (cons x x))

;Global_Env  --------------------------------------------------------------------
;            | cons: ----------\                                                |
;            | x:----\         |                                                |
;            | z:-------\      |                                                | <------------------------------------
;            --------|--|------|-------------------------------------------------                                      \
;                    |  |      |  ^                                  ^                                                 |     E2
;                    |  |      |  |                          E1 -----|----------                                  -----|----------
;                    |  |     (.)(.)                            | x: 1, y: 2   |              |                /----x:<-.-y:<-.  |
;                    |  |     params: x, y                      | set-x: ---------------->(.)(.)<--------------|--- set-x:       |
;                    |  |     body: body-of-cons                | set-y: ...   |         params: v             |  | set-y: ...   |
;                    |  |                                       | dispatch: ...|         body: body-of-set-x   |  | dispatch: ...|
;                    |  |                                       ----------------                               |  ----------------
;                    |  |                                           ^                                          |        ^
;                    \  |                                           |                                          |        |
;                     --|--------------------->(.)(.)----------------                                          /        |
;                       |                      params: m              <----------------------------------------         |
;                       |                      body: body-of-dispatch                                                   |
;                       \                                                                                               |
;                        --------------------->(.)(.)--------------------------------------------------------------------
;                                              params: m
;                                              body: body-of-dispatch


(set-car! (cdr z) 17)
; Too tiresome to draw.
; (cdr x) creates a new environment, E3, encompassed by Global_Env mapping argument z to the parameter z and executes (z 'car) which is the body.
; (z 'car) creates an environment, E4, encompassed by E2 mapping 'car to m and executes body of dispatch which results in x(defined in Global_Env).
; (set-car! x 17) executes, by creating an environment, E5, encompassed by Global_Env mapping arguments x and 17 to params z and new-value respectively.
; The body ((x 'set-car!) new-value) executes.
; To execute (x 'set-car!) a new environment under E1 is created mapping argument 'set-car! to parameter m and executes the body of dispatch resulting in the procedure set-x! defined in E1
; (set-x! 17) is executed changing x's(the one defined inside E1) value to 17

(car x)

;Should be obvious if the previous answer is.

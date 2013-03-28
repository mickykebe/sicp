; a
(define (get-record file employee-name)
    ((get 'get-record (type-tag file)) (contents file) record-key))

;   File-dispatch-table   Division1's-set-implementation       Division2's-set-implementation     Division3's-set-implementation
;                         (let's assume an unordered list)     (let's assume an ordered list)     (let's assume a binary tree)
;
;   get-record            get-record-UOL                       get-record-OL                      get-record-BT

; Each file has a tag denoting the structure in which the set of records are organized.
; With that one only has to build a dispatch table mapping these tags(which can be seen as types) and operations manipulating the contents of the file. get-record in the above definition is an instance of such an operation.

; b
(define (get-salary employee-record)
    ((get 'get-salary (type-tag employee-record)) (contents employee-record)))

;Each record has a tag attached denoting the structure in which the set of employee-info-keys are stored.
;A dispatch table mapping these tags to the operations manipulating every type of record(tag) need be available. get-salary is an instance of such operation

; c
(define (find-employee-record employee-name files)
    (if (null? files)
        '()
        (let ((r (get-record (car file) employee-name)))
            (if (null? r)
                (find-employee-record employee-name (cdr files))
                r))))

; d
; Upon the addition of a division, one only has to populate entries into the 2 dispatch tables.

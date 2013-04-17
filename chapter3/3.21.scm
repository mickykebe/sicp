(define q1 (make-queue))
(insert-queue! q1 'a)
;((a) a)
(insert-queue! q1 'b)
;((a b) b)
(delete-queue! q1)
;((b) b)
(delete-queue! q1)
;(() b)

;Break it up you two!!! Sussman walks out for one minute and you're at each others throats. Shame.

;Eva Lu is right. ... Stop Gloating!!!! Unladylike.

; q1 in this case, or any representation of queues made by make-queue, is not the actual queue but a pair with elements pointing to the front and last elements of the queue respectively. To get to the actual queue printing the front-pointer will do because doing so prints the entire queue structure minus repeating the last element.

(define (print-queue q)
    (display (front-ptr q)))

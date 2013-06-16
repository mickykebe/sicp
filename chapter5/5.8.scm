start
  (goto (label here))
here
  (assign a (const 3))
  (goto (label there))
here
  (assign a (const 4))
  (goto (label there))
there

;The lines below show the values of insts and labels at every stage of extract-labels

;(() ())

;(() ('there ()))

;([8th line] ('there ()))

;(([7th line] [8th line]) ('there ()))

;(([7th line] [8th line]) (('here ([7th...8th line])) ('there ()))

;(([5th line] [7th line] [8th line]) (('here ([7th...8th line])) ('there ()))

;(([4th line] [5th line] [7th line] [8th line]) (('here ([7th...8th line])) ('there ()))

;(([4th line] [5th line] [7th line] [8th line]) (('here ([4th...8th line])) ('here ([7th...8th line])) ('there ()))

;(([2nd line] [4th line] [5th line] [7th line] [8th line]) (('here ([4th...8th line])) ('here ([7th...8th line])) ('there ()))

;(([2nd line] [4th line] [5th line] [7th line] [8th line]) ((start ([2nd...8th line])) ('here ([4th...8th line])) ('here ([7th...8th line])) ('there ()))

;Both "here" labels are found inside the final label pointer table. Inside the table they also maintain their sequence with the first label "here" appearing before the second in the table also.

;So assuming an instruction in finding a label from the table, searches from first to last, then the final value of a would be 3.
;If for some reason the search is conducted in reverse a would have the value 4.

;Modification
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)
                   (error "Multiple instances of the label" next-inst)
                   (receive insts
                            (cons (make-label-entry next-inst
                                                    insts)
                                  labels)))
               (receive (cons (make-instruction next-inst)
                              insts)
                        labels)))))))

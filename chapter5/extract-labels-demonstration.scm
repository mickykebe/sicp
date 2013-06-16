;controller-text
(test-b
   (assign t (op rem) (reg a) (reg b))
   (assign a (reg b)))

(extract-labels '(test-b    ;->text-1
                  (assign t (op rem) (reg a) (reg b))
                  (assign a (reg b)))
                (lambda (insts labels) ;-> p1
                    (update-insts! insts labels machine)
                    insts))

(extract-labels '((assign t (op rem) (reg a) (reg b)) ;->text-2
                  (assign a (reg b)))
                (lambda (insts labels)  ;->p2
                    (let ((next-inst (car text-1)))
                       (if (symbol? next-inst)
                           (p1 insts
                               (cons (make-label-entry next-inst
                                                       insts)
                                     labels))
                           (p1 (cons (make-instruction next-inst)
                                     insts)
                               labels)))

(extract-labels '((assign a (reg b))) ;->text-3
                (lambda (insts labels)  ;->p3
                    (let ((next-inst (car text-2)))
                       (if (symbol? next-inst)
                           (p2 insts
                               (cons (make-label-entry next-inst
                                                       insts)
                                     labels))
                           (p2 (cons (make-instruction next-inst)
                                     insts)
                               labels)))

(extract-labels '() ;->text-4
                (lambda (insts labels)  ;->p4
                    (let ((next-inst (car text-3)))
                       (if (symbol? next-inst)
                           (p3 insts
                               (cons (make-label-entry next-inst
                                                       insts)
                                     labels))
                           (p3 (cons (make-instruction next-inst)
                                     insts)
                               labels)))

;(p4 '() '())

;(p3 '((make-instruction text-3)) '())

;(p2 '((make-instruction text-2) (make-instruction text-3)) '())

;(p1 '((make-instruction text-2) (make-instruction text-3)) '((make-label-entry test-b insts))


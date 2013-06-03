(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (let ((found-word (an-element-of (cdr word-list))))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

;Results
;(sentence (simple-noun-phrase (article the) (noun student)) (verb studies))
;(sentence (simple-noun-phrase (article the) (noun student)) (verb lectures))
;(sentence (simple-noun-phrase (article the) (noun student)) (verb eats))
;(sentence (simple-noun-phrase (article the) (noun student)) (verb sleeps))
;(sentence (simple-noun-phrase (article the) (noun professor)) (verb studies))
;(sentence (simple-noun-phrase (article the) (noun professor)) (verb lectures))
;(sentence (simple-noun-phrase (article the) (noun professor)) (verb eats))

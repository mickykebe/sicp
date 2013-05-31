;The professor lectures to the student in the class with the cat.

;The class has the cat
;The student has the cat
;The professor has the cat
;(The professor) lectures to the student (in the class with the cat)
;The professor lectures to (the student in the calss with the cat)

;parse1:
;(sentence (simple-noun-phrase (article the) (noun professor))
;          (verb-phrase
;               (verb lectures)
;               (prep-phrase 
;                   (prep to)
;                   (noun-phrase
;                       (simple-noun-phrase (article the) (noun student))
;                       (prep-phrase
;                           (prep in)
;                           (noun-phrase 
;                               (simple-noun-phrase (article the) (noun class))
;                               (prep-phrase (prep with)
;                                            (simple-noun-phrase (article the) (noun cat)))))))))

;Meaning: The professor(wherabout unspecified) lectures to the student who is in the class which houses the cat.

;parse2:
;(sentence (simple-noun-phrase (article the) (noun professor))
;          (verb-phrase
;               (verb-phrase
;                   (verb lectures)
;                   (prep-phrase
;                       (prep to)
;                       (noun-phrase
;                           (simple-noun-phrase (article the) (noun student))
;                           (prep-phrase
;                               (prep in)
;                               (simple-noun-phrase (article the) (noun class))))))
;               (prep-phrase
;                   (prep with)
;                   (simple-noun-phrase (article the) (noun cat)))))

;Meaning: The professor(wherabout unspecified) with the cat lectures to the student who is in the class.

;parse3:
;(sentence (simple-noun-phrase  (article the) (noun professor))
;          (verb-phrase
;               (verb-phrase
;                   (verb lectures)
;                   (prep-phrase
;                       (prep to)
;                       (simple-noun-phrase (article the) (noun student))))
;               (prep-phrase
;                   (prep in)
;                   (noun-phrase
;                       (simple-noun-phrase (article the) (noun class))
;                       (prep-phrase
;                           (prep with)
;                           (simple-noun-phrase (article the) (noun cat)))))))

;Meaning: The professor in the class housing the cat lectures the student(whose wherabout is unspecified).

;parse4:
;(sentence (simple-noun-phrase (article the) (noun professor))
;          (verb-phrase
;               (verb lectures)
;               (prep-phrase 
;                   (prep to)
;                   (noun-phrase
;                       (noun-phrase
;                           (simple-noun-phrase (article the) (noun student))
;                           (prep-phrase
;                               (prep in)
;                               (simple-noun-phrase (article the) (noun class))))
;                       (prep-phrase
;                           (prep with)
;                           (simple-noun-phrase (article the) (noun cat)))))))

;Meaning: The professor(wherabout unspecified) lectures the student who is both inside the class and holding the cat.

;parse5:
;(sentence (simple-noun-phrase (article the) (noun professor))
;          (verb-phrase
;               (verb-phrase
;                   (verb-phrase
;                       (verb lectures)
;                       (prep-phrase
;                           (prep to)
;                           (simple-noun-phrase (article the) (noun student))))
;                   (prep-phrase
;                       (prep in)
;                       (simple-noun-clause (article the) (noun class))))
;               (prep-phrase
;                   (prep with)
;                   (simple-noun-clause (article the) (noun cat)))))

;Meaning: The professor who is both inside the class and holding the cat lectures the student(whearabout unspecified)

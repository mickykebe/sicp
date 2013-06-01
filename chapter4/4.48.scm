;Adding adjectives to the grammer could be done by extending a noun phrase to be composed not only of simple noun phrases, but also by "simple noun phrases with adjectives"

(define adjectives '(adjective icy shrill yummy massive))

(define (parse-adjective-noun-phrase)
    (list 'adjective-noun-phrase
          (parse-word articles)
          (parse-word adjectives)
          (parse-word nouns)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (amb (parse-simple-noun-phrase) (parse-adjective-noun-phrase))))

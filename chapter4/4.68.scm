(rule (reverse () ()) ())

(rule (reverse ?x ?y)
    (and (append-to-form ?car ?cdr ?x)
         (append-to-form ?rcar ?rcdr ?y)
         (reverse ?cdr ?rcdr)))

;Don't know how it works yet.

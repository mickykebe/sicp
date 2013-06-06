(rule (grandfather-of ?g ?s)
    (and (son ?f ?s) (son ?g ?f)))

(rule (son-of ?m ?s)
    (and (wife ?m ?w)
         (son ?w ?s)))

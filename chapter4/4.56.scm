;a)
(and (supervisor ?name (Bitdiddle Ben))
     (address ?name ?adres))

;b)
(and (salary (Bitdiddle Ben) ?amount)
     (salary ?name ?amnt)
     (lisp-value > ?amount ?amnt))

;c)
(and (supervisor ?spvd ?spisor)
     (not (job ?spisor (computer . ?work)))
     (job ?spisor ?position))

(car ''abracadabra)

; Taking into account the fact that the interpreter, behind the scenes, uses the special form "quote" to substitute "'" the expression ''abracadabra boils down to

; (quote (quote abracadabra))

;Hence the the expression (quote abracadabra) is taken as a symbol, whose car value is the symbol quote

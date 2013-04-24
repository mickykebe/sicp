(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

;Louis reasoner is mistaken here. The problem with exchange is the presence of the intermediate "difference" which in certain cases of parallel execution holds an erroneous value. The procedure above has no such problems. Any juxtaposition of withdraw and deposit under many parallel executions of transfer always yields the correct result in the end.

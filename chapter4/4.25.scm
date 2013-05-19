;With applicative order evaluation, the call to factorial, as an argument to unless, being evaluated first -- before the logic of unless -- results in an infinite recursion.
;The definition works fine in normative-order as the logic comes first and hence the call to factorial proceeds until n equals 1.

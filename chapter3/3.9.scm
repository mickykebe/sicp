;a)
;            GLOBAL_ENV
;_______________________________________________________________________________________________________________
;   ||                              ||                              ||                                  ||
;  \  /                            \  /                            \  /                                \  /
;   \/                              \/                              \/                                  \/
;E1: n:6                        E2: n:5                          E3: n:4                           E6: n:1
;   (if (= n 1)                     (if (= n 1)                      (if (= n 1)            ......     (if (= n 1)
;     1                               1                                1                                 1
;     (* n (factorial (- n 1))))      (* n (factorial (- n 1))))       (* n (factorial (- n 1))))        (* n (factorial (- n 1))))
;
;b)
;            GLOBAL_ENV
;_______________________________________________________________________________________________________________
;   ||                              ||                              ||                                  ||
;  \  /                            \  /                            \  /                                \  /
;   \/                              \/                              \/                                  \/
;E1: n:6                  E2: product:1                    E3: product:1                     E8: product:720
;   (fact-iter 1 1 n)         counter:1                        counter:2              ......     counter:7
;                             max-count:6                      max-count:6                       max-count:6
;                             (if (> counter max-count)        (if (> counter max-count)         (if (> counter max-count)
;                                 product                          product                           product
;                                 (fact-iter (* counter product)   (fact-iter (* counter product)    (fact-iter (* counter product)
;                                             (+ counter 1)                    (+ counter 1)                     (+ counter 1)
;                                             max-count))                      max-count))                       max-count))

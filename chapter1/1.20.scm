;GCD(206,40)
          |
    ;GCD( |, remainder(206,40)) -> 1
              |
        ;GCD( |, remainder(40,remainder(206,40))) -> 2
                  |
            ;GCD( |, remainder(remainder(206,40), remainder(40, remainder(206,40)))) -> 4
                      |
                ;GCD( |, remainder(remainder(40,remainder(206,40)), remainder(remainder(206,40), remainder(40, remainder(206,40))))) -> 7+4=11

; 11+4+2+1 = 18

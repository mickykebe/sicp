;a)
(meeting ?scope (Friday ?time))

;b)
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
          (and (job ?person (?division . ?position))
               (meeting ?division ?day-and-time))))

;c)
(meeting-time (Hacker Alyssa P) (Wednesday ?time))

(define (problem sar_simple_same)
    (:domain sar_simple)
    (:objects
        d0 d1 - drone ; d2
        a0 a1 a2 a3 a4 h0 h1 - location ; locations and helipads connected to them
    )
    (:init
        ; 2 drones landed at helipads
        (drone_at d0 h0)
        (landed d0)

        (drone_at d1 h1)
        (landed d1)

        
        (can_land h0)
        (can_land h1)

        ; areas
        (path a0 a1)
        (path a1 a0)
        (path a0 a2)
        (path a2 a0)
        (path a2 a3)
        (path a3 a2)
        (path a3 a4)
        (path a4 a3)

        ; (path a5 a6)
        ; (path a6 a5)
        ; (path a6 a7)
        ; (path a7 a6)
        
        ; helipads and connected area
        (path h0 a0)
        (path a0 h0)
        (path h0 a3)
        (path a3 h0)
        ; (path h0 a5)
        ; (path a5 h0)
        
        (path h1 a2)
        (path a2 h1)
        (path h1 a4)
        (path a4 h1)
    )
    (:goal
        (and
            (searched a0)
            (searched a1)
            (searched a2)
            (searched a3)
            (searched a4)
            ; (searched a5)
            ; (searched a6)
            ; (searched a7)

            (drone_at d0 h0)
            (landed d0)

            (drone_at d1 h1)
            (landed d1)
        )
    )
    (:metric minimize (total-time))
)
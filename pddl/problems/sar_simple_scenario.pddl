(define (problem sar_simple_scenario)
    (:domain sar_simple)
    (:objects
        d0 - drone ; d2
        a0 a1 a2 h0 h1 - location ; locations and helipads connected to them
    )
    (:init
        ; 2 drones landed at helipads
        (drone_at d0 h0)
        (landed d0)
        ; (not searching d0)
        ; (drone_at d2 h1)
        ; (landed d2)
        
        (can_land h0)
        (can_land h1)

        ; areas
        (path a0 a1)
        (path a1 a0)
        (path a0 a2)
        (path a2 a0)
        
        ; helipads and connected area
        (path a0 h0)
        (path h0 a0)
        (path a1 h1)
        (path h1 a1)
    )
    (:goal
        (and
            (searched a0)
            (searched a1)
            (searched a2)

            (drone_at d0 h1)
            (landed d0)

            ; (drone_at d2 h0)
            ; (landed d2)
        )
    )
    (:metric minimize (total-time))
)
(define (problem sar_simple_scenario)
    (:domain sar_simple)
    (:objects
        d1 - drone ; d2
        a1 a2 a3 h1 h2 - location ; locations and helipads connected to them
    )
    (:init
        ; 2 drones landed at helipads
        (drone_at d1 h1)
        (landed d1)
        ; (not searching d1)
        ; (drone_at d2 h2)
        ; (landed d2)
        
        (can_land h1)
        (can_land h2)

        ; areas
        (path a1 a2)
        (path a2 a1)
        (path a1 a3)
        (path a3 a1)
        
        ; helipads and connected area
        (path a1 h1)
        (path h1 a1)
        (path a2 h2)
        (path h2 a2)
    )
    (:goal
        (and
            (searched a1)
            (searched a2)
            (searched a3)

            (drone_at d1 h2)
            (landed d1)

            ; (drone_at d2 h1)
            ; (landed d2)
        )
    )
)
(define (problem sar_simple_scenario)
    (:domain sar_simple)
    (:objects
        d0 - drone
        a1 a2 a3 h1 h2 - location ; locations and helipads connected to them
    )
    (:init
        (drone_at d0 h1)
        (landed d0)

        (can_land a1)
        (can_land a2)

        (path a1 a2)
        (path a2 a1)
        (path a1 a3)
        (path a3 a1)
        
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
            (drone_at d0 h2)
            (landed d0)
        )
    )
)
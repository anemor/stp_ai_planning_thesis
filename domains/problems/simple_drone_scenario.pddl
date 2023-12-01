(define (problem simple_drone_scenario)
    (:domain simple_drone)
    (:objects
        d0 - drone
        a1 a2 a3 h1 h2 - location ; locations and helipads connected to them
    )
    (:init
        (drone_at d0 h1)
        (landed d0)

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
            (drone_at d0 h2)
            (landed d0)
        )
    )
)
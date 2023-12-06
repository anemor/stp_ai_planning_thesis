(define (problem test)
    (:domain sar)
    (:objects
        D0 - drone
        A1 A2 A3 H1 H2 - location ; locations and helipads connected to them
    )
    (:init
        (drone_at D0 H1)
        (landed D0)

        (can_land A1)
        (can_land A2)

        (path A1 A2)
        (path A2 A1)
        (path A1 A3)
        (path A3 A1)
        
        (path A1 H1)
        (path H1 A1)
        (path A2 H2)
        (path H2 A2)
    )
    (:goal
        (and
            (searched A1)
            (searched A2)
            (searched A3)
            (drone_at D0 H2)
            (landed D0)
        )
    )
)
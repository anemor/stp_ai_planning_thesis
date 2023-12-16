(define (problem sar_simple_same)
    (:domain sar_simple)
    (:objects
        d0 d1 - drone ; d1
        a0 a1 a2 a3 a4 a5 a6 a7 h0 h1 - location ; locations and helipads connected to them ;a5 a6 a7
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

        (path a5 a6)
        (path a6 a5)
        (path a6 a7)
        (path a7 a6)
        
        ; helipads and connected area
        (path h0 a0)
        (path a0 h0)
        (path h0 a3)
        (path a3 h0)
        (path h0 a5)
        (path a5 h0)
        
        (path h1 a2)
        (path a2 h1)
        (path h1 a4)
        (path a4 h1)



        ; distances on the map
        ( = ( distance h0 a0 ) 20 )
        ( = ( distance h0 a3 ) 20 )
        ( = ( distance h0 a5 ) 20 )
        ( = ( search_distance h0 ) 19 )

        ( = ( distance h1 a2 ) 44.7214 )
        ( = ( distance h1 a4) 40) ;;;;;;;;
        ; ( = ( distance h1 elz0 ) 60 )
        ( = ( search_distance h1 ) 19 )

        ( = ( distance a0 h0 ) 20 )
        ( = ( distance a0 a1 ) 20 )
        ( = ( distance a0 a2 ) 20 )
        ( = ( search_distance a0 ) 19 )

        ( = ( distance a1 a0 ) 20 )
        ; ( = ( distance a1 elz0 ) 20 )
        ( = ( search_distance a1 ) 19 )

        ( = ( distance a2 h1 ) 28.2843 )
        ( = ( distance a2 a0 ) 20 )
        ( = ( distance a2 a3 ) 20 )
        ( = ( search_distance a2 ) 19 )

        ( = ( distance a3 h0 ) 20 )
        ( = ( distance a3 a2 ) 20 )
        ( = ( distance a3 a4 ) 20 )
        ( = ( search_distance a3 ) 19 )

        ( = ( distance a4 a3 ) 20 )
        ( = ( distance a4 h1 ) 40 )
        ( = ( search_distance a4 ) 19 )

        ( = ( distance a5 h0 ) 20 )
        ( = ( distance a5 a6 ) 20 )
        ( = ( search_distance a5 ) 19 )

        ( = ( distance a6 a5 ) 20 )
        ( = ( distance a6 a7 ) 20 )
        ( = ( search_distance a6 ) 19 )

        ( = ( distance a7 a6 ) 20 )
        ; ( = ( distance a7 elz1 ) 20 )
        ( = ( search_distance a7 ) 19 )

        ; ( = ( distance elz0 a1 ) 20 )
        ; ( = ( search_distance elz0 ) 19 )
        
        ; ( = ( distance elz1 a7 ) 20 )
        ; ( = ( search_distance elz1 ) 19 )


        ; ( = ( track_battery_usage d0 ) 0.05896 )
        ; ( = ( move_battery_usage d0 ) 0.06201 )
        ( = ( track_velocity d0 ) 0.2 )
        ( = ( move_velocity d0 ) 2 )

        ( = ( track_velocity d1 ) 0.2 )
        ( = ( move_velocity d1 ) 2 )
    )
    (:goal
        (and
            (searched a0)
            (searched a1)
            (searched a2)
            (searched a3)
            (searched a4)
            (searched a5)
            (searched a6)
            (searched a7)

            (drone_at d0 h0)
            (landed d0)

            (drone_at d1 h1)
            (landed d1)
        )
    )
    (:metric minimize (total-time))
)
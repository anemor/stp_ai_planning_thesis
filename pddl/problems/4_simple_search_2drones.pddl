(define (problem sar_simple_same_supply)
    (:domain sar_simple_supply)
    (:objects
        d0 d1 - drone ;
        h0 h1 a0 a1 a2 a3 a4 a5 a6 a7 elz0 elz1 - location
        p0 - person
    )
    (:init
        ; 1 drones landed at helipads
        ; (drone_at d0 h0)
        (drone_at d0 elz1)
        (landed d0)
        (lifevest_available d0)
        (marker_available d0)

        (drone_at d1 h1)
        (landed d1)
        (lifevest_available d1)
        (marker_available d1)
        
        (can_land h0)
        (can_land h1)
        ; (can_land elz0) ; remove for 4c to go fast
        (can_land elz1)

        (can_recharge h0)
        (can_recharge h1)
        ; (can_recharge elz0) ; remove for 4c to go fast
        (can_recharge elz1)

        (can_resupply h0)
        (can_resupply h1)
        ; (can_resupply elz0) ; remove for 4c to go fast
        (can_resupply elz1)
    
        ; MAP ;;;;;;;;;;;;;;;;;;;;;
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

        ; emergency landing zones
        ; (path a1 elz0) ; remove for 4c to go fast
        ; (path elz0 a1) ; remove for 4c to go fast
        (path a7 elz1)
        (path elz1 a7)



        ; distances on the map
        ( = ( distance h0 a0 ) 20 )
        ( = ( distance h0 a3 ) 20 )
        ( = ( distance h0 a5 ) 20 )
        ( = ( search_distance h0 ) 19 )

        ( = ( distance h1 a2 ) 44.7214 )
        ( = ( distance h1 a4) 40) ;;;;;;;;
        ( = ( distance h1 elz0 ) 60 )
        ( = ( search_distance h1 ) 19 )

        ( = ( distance a0 h0 ) 20 )
        ( = ( distance a0 a1 ) 20 )
        ( = ( distance a0 a2 ) 20 )
        ( = ( search_distance a0 ) 19 )

        ( = ( distance a1 a0 ) 20 )
        ( = ( distance a1 elz0 ) 20 )
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
        ( = ( distance a7 elz1 ) 20 )
        ( = ( search_distance a7 ) 19 )

        ; ( = ( distance elz0 a1 ) 20 ) ; remove for 4c to go fast
        ; ( = ( search_distance elz0 ) 19 ) ; remove for 4c to go fast
        
        ( = ( distance elz1 a7 ) 20 )
        ( = ( search_distance elz1 ) 19 )


        ; velocities
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

            ; (drone_at d0 h0)
            (drone_at d0 elz1)
            (landed d0)

            (drone_at d1 h1)
            (landed d1)
        )
    )
    ; (:metric minimize (total-time))
)
 ; remove for 4c to go fast
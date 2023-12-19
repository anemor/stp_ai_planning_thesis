(define (problem sar_simple_same_supply)
    (:domain sar_simple_supply)
    (:objects
        d0 d1 - drone ;
        h0 h1 a0 a1 a2 a3 a4 a5 a6 a7 elz0 elz1 - location
        p0 - person
    )
    (:init
        ; 1 drones landed at helipads
        (drone_at d0 h0)
        (landed d0)
        (lifevest_available d0)
        (marker_available d0)
        
        (can_land h0)
        (can_land h1)
        (can_land elz0)
        (can_land elz1)

        (can_recharge h0)
        (can_recharge h1)
        (can_recharge elz0)
        (can_recharge elz1)

        (can_resupply h0)
        (can_resupply h1)
        (can_resupply elz0)
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
        (path h1 elz0)
        (path elz0 h1)
        (path a1 elz0)
        (path elz0 a1)
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
        ; ( = ( distance a7 elz1 ) 20 )
        ( = ( search_distance a7 ) 19 )

        ( = ( distance elz0 a1 ) 20 )
        ( = ( search_distance elz0 ) 19 )
        
        ( = ( distance elz1 a7 ) 20 )
        ( = ( search_distance elz1 ) 19 )


        ; velocities
        ( = ( track_velocity d0 ) 0.2 )
        ( = ( move_velocity d0 ) 2 )

        ; ( = ( track_velocity d1 ) 0.2 )
        ; ( = ( move_velocity d1 ) 2 )



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

            (drone_at d0 h1) ; h1
            (landed d0)
        )
    )
    ; (:metric minimize (total-time))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; set instance d0 drone
; set instance d1 drone
; set instance h0 location
; set instance h1 location
; set instance a0 location
; set instance a1 location
; set instance a2 location
; set instance a3 location
; set instance a4 location
; set instance a5 location
; set instance a6 location
; set instance a7 location
; set instance elz0 location
; set instance elz1 location
; set instance p0 person



; set predicate (drone_at d0 h0)
; set predicate (landed d0)
; set predicate (lifevest_available d0)
; set predicate (marker_available d0)

; set predicate (can_land h0)
; set predicate (can_land h1)
; set predicate (can_land elz0)
; set predicate (can_land elz1)

; set predicate (can_recharge h0)
; set predicate (can_recharge h1)
; set predicate (can_recharge elz0)
; set predicate (can_recharge elz1)

; set predicate (can_resupply h0)
; set predicate (can_resupply h1)
; set predicate (can_resupply elz0)
; set predicate (can_resupply elz1)

; set predicate (path a0 a1)
; set predicate (path a1 a0)
; set predicate (path a0 a2)
; set predicate (path a2 a0)
; set predicate (path a2 a3)
; set predicate (path a3 a2)
; set predicate (path a3 a4)
; set predicate (path a4 a3)

; set predicate (path a5 a6)
; set predicate (path a6 a5)
; set predicate (path a6 a7)
; set predicate (path a7 a6)

; set predicate (path h0 a0)
; set predicate (path a0 h0)
; set predicate (path h0 a3)
; set predicate (path a3 h0)
; set predicate (path h0 a5)
; set predicate (path a5 h0)

; set predicate (path h1 a2)
; set predicate (path a2 h1)
; set predicate (path h1 a4)
; set predicate (path a4 h1)

; set predicate (path h1 elz0)
; set predicate (path elz0 h1)
; set predicate (path a1 elz0)
; set predicate (path elz0 a1)
; set predicate (path a7 elz1)
; set predicate (path elz1 a7)



; ; distances on the map
; set function ( = ( distance h0 a0 ) 20 )
; set function ( = ( distance h0 a3 ) 20 )
; set function ( = ( distance h0 a5 ) 20 )
; set function ( = ( search_distance h0 ) 19 )

; set function ( = ( distance h1 a2 ) 44.7214 )
; set function ( = ( distance h1 a4) 40) 
; set function ( = ( distance h1 elz0 ) 60 )
; set function ( = ( search_distance h1 ) 19 )

; set function ( = ( distance a0 h0 ) 20 )
; set function ( = ( distance a0 a1 ) 20 )
; set function ( = ( distance a0 a2 ) 20 )
; set function ( = ( search_distance a0 ) 19 )

; set function ( = ( distance a1 a0 ) 20 )
; set function ( = ( distance a1 elz0 ) 20 )
; set function ( = ( search_distance a1 ) 19 )

; set function ( = ( distance a2 h1 ) 28.2843 )
; set function ( = ( distance a2 a0 ) 20 )
; set function ( = ( distance a2 a3 ) 20 )
; set function ( = ( search_distance a2 ) 19 )

; set function ( = ( distance a3 h0 ) 20 )
; set function ( = ( distance a3 a2 ) 20 )
; set function ( = ( distance a3 a4 ) 20 )
; set function ( = ( search_distance a3 ) 19 )

; set function ( = ( distance a4 a3 ) 20 )
; set function ( = ( distance a4 h1 ) 40 )
; set function ( = ( search_distance a4 ) 19 )

; set function ( = ( distance a5 h0 ) 20 )
; set function ( = ( distance a5 a6 ) 20 )
; set function ( = ( search_distance a5 ) 19 )

; set function ( = ( distance a6 a5 ) 20 )
; set function ( = ( distance a6 a7 ) 20 )
; set function ( = ( search_distance a6 ) 19 )

; set function ( = ( distance a7 a6 ) 20 )

; set function ( = ( search_distance a7 ) 19 )

; set function ( = ( distance elz0 a1 ) 20 )
; set function ( = ( search_distance elz0 ) 19 )

; set function ( = ( distance elz1 a7 ) 20 )
; set function ( = ( search_distance elz1 ) 19 )


; set function ( = ( track_velocity d0 ) 0.2 )
; set function ( = ( move_velocity d0 ) 2 )



; set goal (and(searched a0)(searched a1)(searched a2)(searched a3)(searched a4)(searched a5)(searched a6)(searched a7)(drone_at d0 h0)(landed d0))
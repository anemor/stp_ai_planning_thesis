(define (problem maritimeDomain) (:domain mass-ntnu)
(:objects
cont_x cont_y cont_w cont_z - cont
teamR0 - teamR
teamF0 - teamF
ship0 - ship
motor0 - motor
port_A port_B port_C port_D port_E port_S  - port
A B C D E S - city
port_AB port_BC port_CD port_DE port_SA port_SB port_SC port_SD port_SE - route
)
(:init
(= (speed ship0) 0.18)

(in_city port_A A)
(in_city port_B B)
(in_city port_C C)
(in_city port_D D)
(in_city port_E E)
(in_city port_S S)
(route_available port_AB)
(route_available port_BC)
(route_available port_CD)
(route_available port_DE)
(route_available port_SA)
(route_available port_SB)
(route_available port_SC)
(route_available port_SD)
(route_available port_SE)
(connects port_AB A B)
(connects port_BC B C)
(connects port_CD C D)
(connects port_DE D E)
(connects port_SA S A)
(connects port_SB S B)
(connects port_SC S C)
(connects port_SD S D)
(connects port_SE S E)
(= (route-length port_AB)   40   )
(= (route-length port_BC)   100   )
(= (route-length port_CD)   100   )
(= (route-length port_DE)   100   )
(= (route-length port_SA)   10   )
(= (route-length port_SB)   8   )
(= (route-length port_SC)   8   )
(= (route-length port_SD)   8   )
(= (route-length port_SE)   8   )
(available ship0  )
(no_rep ship0  )
(no_fuel ship0  )
(at ship0 port_A  )
(at cont_x port_A  )
(at cont_y port_B  )
(at cont_w port_C  )
(at cont_z port_D  )
(at teamR0 port_E  )
(at teamF0 port_E  )

)
(:goal (and
(at ship0 port_E)
(at cont_x port_B)
(at cont_y port_C)
(at cont_w port_D)
(loaded cont_z ship0)
(busy ship0)
(repaired ship0)
(refuel ship0)
))
(:metric minimize (total-time))
)

(define (domain sar_simple_supply)
    (:requirements 
        :strips 
        :typing 
        :fluents 
        :durative-actions 
        :negative-preconditions
    )
    (:types 
        drone - vehicle
        marker lifevest - equipment
        person location - trackable) 
    (:predicates
        (drone_at ?d - drone ?loc - location)
        (person_at ?p - person ?loc - location)

        (path ?loc_from ?loc_to - location)
        (landed ?d - drone)
        
        ; (available ?loc - location) 

        (can_land ?loc - location)
        (can_resupply ?loc - location)
        (can_recharge ?loc - location)

        (searched ?loc - location)

        (tracked ?p - person) ; Tracking either a person or a landing location
        (marked ?p - person ?loc - location) ; Dropping marker
        (rescued ?p - person ?loc - location) ; Dropping lifevest
        (communicated ?p - person ?loc - location) ; Communicating about position

        ; not sure if these are needed
        (rescuing ?d - drone)
        (marking ?d - drone)
        (tracking ?d - drone) 

        (marker_available ?d - drone)
        (lifevest_available ?d - drone) 

        (battery_charged ?d - drone)
    )

    (:functions
        (distance ?loc_from - location ?loc_to - location)
        (search_distance ?loc - location)
        
        (move_velocity ?d - drone)
        (track_velocity ?d - drone) 
        
        (battery_charge ?d - drone)

        ; (marker_available ?d - drone)
        ; (lifevest_available ?d - drone)    
    )

    (:durative-action MOVE
        :parameters (
            ?d - drone 
            ?loc_from - location
            ?loc_to - location
        )
        :duration (= ?duration (/ (distance ?loc_from ?loc_to)(move_velocity ?d))); (= ?duration 20)
        :condition (and 
            (at start (drone_at ?d ?loc_from))
            (at start (path ?loc_from ?loc_to))
            (over all (not (landed ?d)))
        )
        :effect (and
            (at start (not ( drone_at ?d ?loc_from )))
            (at end ( drone_at ?d ?loc_to ))
        )
    )
    (:durative-action LAND
        :parameters (
            ?d - drone 
            ?loc - location ; helipad
        )
        :duration (= ?duration 30)
        :condition (and 
            (over all (drone_at ?d ?loc)) ; i stedet for at start, fiksa feil med land og 
            (at start (not (landed ?d)))
            (at start (searched ?loc))  ; to specify helipad location from other locations
            (at start (can_land ?loc))
        )
        :effect (and
            (at end (landed ?d))
            ; (at end (drone_at ?d ?loc))
        )
    )
    (:durative-action TAKEOFF
        :parameters (
            ?d - drone 
            ?loc - location
        )
        :duration (= ?duration 5)
        :condition (and  
            (over all (drone_at ?d ?loc))
            (at start (landed ?d))
        )
        :effect (and
            (at end (not (landed ?d)))
        )
    )
    (:durative-action SEARCH
        :parameters (
            ?d - drone 
            ?loc - location
        )
        :duration ( = ?duration (/ (search_distance ?loc) (track_velocity ?d))); (= ?duration 20)
        :condition (and 
            (over all (drone_at ?d ?loc))
            (over all (not (landed ?d))) ; to prevent searching before/at same time as takeoff
            (at start (not (searched ?loc)))
        )
        :effect (and 
            (at end (searched ?loc))
        )
    )
    (:durative-action COMMUNICATE
        :parameters (?d - drone ?loc - location ?p - person)
        :duration ( = ?duration 1)
        :condition (and
            ; (at start(drone_at ?d ?loc))
            (over all(person_at ?p ?loc))
            (at start(not (communicated ?p ?loc)))
            (at start(tracked ?p))
            (over all(not (landed ?d)))
            (over all(drone_at ?d ?loc))
            ; (over all(not_moving ?d))
        )
        :effect (and
            (at end(communicated ?p ?loc))
        )
    )
    (:durative-action TRACK
        :parameters (?d - drone ?loc - location ?p - person)
        :duration (= ?duration 20)
        :condition (and 
            (at start(searched ?loc))
            (at start (not (tracked ?p)))
            (at start (person_at ?p ?loc))
            (over all (drone_at ?d ?loc)) ; (over all (drone_at ?d ?loc)) ; Is it a problem with over-all again?? Problem with being at a location when the predicate was removed
            ; (over all(not_moving ?d))
        )
        :effect (and
            (at start(tracking ?d))
            (at end (not (tracking ?d)))
            (at end (tracked ?p))
        )
    )
    (:durative-action DROP_MARKER
        :parameters (?d - drone ?loc - location ?p - person); ?m - marker)
        :duration (= ?duration 2)
        :condition (and 
            ;; (at start(drone_at ?d ?loc))
            (over all(drone_at ?d ?loc))
            (over all (person_at ?p ?loc))
            (at start(not (marked ?p ?loc)))
            (at start(tracked ?p))
            ; (at start(>= (marker_available ?d) 1))
            (at start (marker_available ?d))
            (over all(not (landed ?d)))
            ;; (over all(not_moving ?d))
        )
        :effect (and 
            ; (at start (decrease (battery_charge ?d) (* (track_battery_usage ?d) 2)))
            (at start(marking ?d)) ; HVORFOR MARKING ?? HVA BRUKES DET TIL?
            (at end(not (marking ?d)))
            ; (at end(decrease (marker_available ?d) 1))
            (at end (not (marker_available ?d)))
            (at end(marked ?p ?loc))
            ; (at end (not (battery_charged ?d))) ; MIDLERTIDIG FOR TESTING :DD

        )
    )
    (:durative-action DROP_LIFEVEST
        :parameters (?d - drone ?loc - location ?p - person); ?l - lifevest)
        :duration ( = ?duration 2)
        :condition (and
            ; (at start(drone_at ?d ?loc))
            (over all(drone_at ?d ?loc))
            (at start(person_at ?p ?loc))
            (at start(not (rescued ?p ?loc))) ; rescued == lifevest
            (at start(tracked ?p))
            ; (at start(>= (lifevest_available ?d) 1))
            (at start (lifevest_available ?d))
            (over all(not (landed ?d)))
            ; (over all(not_moving ?d))
        )
        :effect (and
            ; (at start (decrease (battery_charge ?d) (* (track_battery_usage ?d) 2)))
            (at start(rescuing ?d))
            (at end(not (rescuing ?d)))
            ; (at end(decrease (lifevest_available ?d) 1))
            (at end (not (lifevest_available ?d)))
            (at end(rescued ?p ?loc))
        )
    )
    
    (:durative-action RECHARGE
        :parameters (?d - drone ?loc - location)
        :duration ( = ?duration (* 0.25 (- 100 (battery_charge ?d)))) ; 4 percent per time unit
        :condition (and
            (over all(drone_at ?d ?loc))
            (over all(landed ?d))
            (at start(can_recharge ?loc))
            (at start(not (battery_charged ?d))) ; (at start(< (battery_charge ?d) 100))
        )
        :effect (and
            (at end (battery_charged ?d));(at end(assign (battery_charge ?d) 100)) ; Could extend this to increasing the charge with respect to time
        )
    )

    (:durative-action RESUPPLY
        :parameters (?d - drone ?loc - location)
        :duration ( = ?duration (+ 10 5 ));(* 10 (- 1 (num_lifevests ?d))) (* 5 (- 2 (num_markers ?d))))) ; Time dependent on adding markers and lifevests
        :condition (and
            (over all(drone_at ?d ?loc))
            (over all(landed ?d))
            (at start(can_resupply ?loc))
            (at start(not (lifevest_available ?d)))
            (at start(not (marker_available ?d)))
        )
        :effect (and
            (at end (lifevest_available ?d)) ;(at end(assign (num_lifevests ?d) 1))
            (at end (marker_available ?d ));(at end(assign (num_markers ?d) 2))
        )
    )
)
(define (domain sar_simple)
    (:requirements 
        :strips 
        :typing 
        :fluents 
        :durative-actions 
        :negative-preconditions
    )
    (:types drone location) ; person
    (:predicates
        (drone_at ?d - drone ?loc - location)
        ; (person_at ?p - person ?loc - location)
        (path ?loc_from ?loc_to - location)
        (landed ?d - drone)
        ; (searching ?d - drone) ; only needed if another action can happen while searching
        
        (searched ?loc - location)
        (can_land ?loc - location)
    )

    (:functions
        (distance ?loc_from - location ?loc_to - location)
        (search_distance ?loc - location)
        
        (move_velocity ?d - drone)
        (track_velocity ?d - drone) 
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
            (at start (not (searched ?loc)))
        )
        :effect (and 
            (at end (searched ?loc))
        )
    )
)
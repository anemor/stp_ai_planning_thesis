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
        (searching ?d - drone) ; only needed if another action can happen while searching
        
        (searched ?loc - location)
        (can_land ?loc - location)
    )

    (:durative-action MOVE
        :parameters ( ?d - drone ?loc_from ?loc_to - location)
        :duration (= ?duration 30)
        :condition (and 
            (at start (path ?loc_from ?loc_to))
            (at start (drone_at ?d ?loc_from))
            (at start (not (landed ?d)))
            (at start (not (searching ?d)))
        )
        :effect (and
            (at start (not (drone_at ?d ?loc_from)))
            (at end (drone_at ?d ?loc_to))
        )
    )
    (:durative-action LAND
        :parameters ( ?d - drone ?loc - location)
        :duration (= ?duration 10)
        :condition (and 
            (at start (drone_at ?d ?loc))
            (at start (not (landed ?d)))
            (at start (searched ?loc))  ; to specify helipad location from other locations
            (over all (can_land ?loc))
        )
        :effect (and
            (at end (landed ?d))
        )
    )
    (:durative-action TAKEOFF
        :parameters ( ?d - drone ?loc - location)
        :duration (= ?duration 5)
        :condition (and  
            (at start (drone_at ?d ?loc))
            (at start (landed ?d))
        )
        :effect (and
            (at end (not (landed ?d)))
        )
    )
    (:durative-action SEARCH
        :parameters (?d - drone ?loc - location)
        :duration (= ?duration 20)
        :condition (and 
            (at start (drone_at ?d ?loc))
            (at start (not (searching ?d)))
            (at start (not (searched ?loc)))
            (at start (not (landed ?d)))
        )
        :effect (and 
            (at start (searching ?d))
            (at end (not (searching ?d)))
            (at end (searched ?loc))
            (at end (not (landed ?d)))
        )
    )
)
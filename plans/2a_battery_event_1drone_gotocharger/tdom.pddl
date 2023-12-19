(define (domain plansys2)
(:requirements 
 :durative-actions :fluents :negative-preconditions :strips :typing )

(:types
        drone - vehicle
        marker lifevest - equipment
        person location - trackable
)

(:predicates
        (battery_charged ?d - drone)
        (can_land ?loc - location)
        (can_recharge ?loc - location)
        (can_resupply ?loc - location)
        (communicated ?p - person ?loc - location) 
        (drone_at ?d - drone ?loc - location)
        (landed ?d - drone)
        (lifevest_available ?d - drone) 
        (marked ?p - person ?loc - location) 
        (marker_available ?d - drone)
        (marking ?d - drone)
        (path ?loc_from ?loc_to - location)
        (person_at ?p - person ?loc - location)
        (rescued ?p - person ?loc - location) 
        (rescuing ?d - drone)
        (searched ?loc - location)
        (tracked ?p - person) 
        (tracking ?d - drone) 
)

(:functions
        (distance ?loc_from - location ?loc_to - location)
        (search_distance ?loc - location)
        (move_velocity ?d - drone)
        (track_velocity ?d - drone) 
        (battery_charge ?d - drone)
)

(:durative-action move
        :parameters (
            ?d - drone 
            ?loc_from - location
            ?loc_to - location
        )
        :duration (= ?duration (/ (distance ?loc_from ?loc_to)(move_velocity ?d)))
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
(:durative-action land
        :parameters (
            ?d - drone 
            ?loc - location 
        )
        :duration (= ?duration 30)
        :condition (and 
            (over all (drone_at ?d ?loc)) 
            (at start (not (landed ?d)))
            (at start (searched ?loc))  
            (at start (can_land ?loc))
        )
        :effect (and
            (at end (landed ?d))
        )
    )
(:durative-action takeoff
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
(:durative-action search
        :parameters (
            ?d - drone 
            ?loc - location
        )
        :duration ( = ?duration (/ (search_distance ?loc) (track_velocity ?d)))
        :condition (and 
            (over all (drone_at ?d ?loc))
            (over all (not (landed ?d))) 
            (at start (not (searched ?loc)))
        )
        :effect (and 
            (at end (searched ?loc))
        )
    )
(:durative-action communicate
        :parameters (?d - drone ?loc - location ?p - person)
        :duration ( = ?duration 1)
        :condition (and
            (over all(person_at ?p ?loc))
            (at start(not (communicated ?p ?loc)))
            (at start(tracked ?p))
            (over all(not (landed ?d)))
            (over all(drone_at ?d ?loc))
        )
        :effect (and
            (at end(communicated ?p ?loc))
        )
    )
(:durative-action track
        :parameters (?d - drone ?loc - location ?p - person)
        :duration (= ?duration 20)
        :condition (and 
            (at start(searched ?loc))
            (at start (not (tracked ?p)))
            (at start (person_at ?p ?loc))
            (over all (drone_at ?d ?loc)) 
        )
        :effect (and
            (at start(tracking ?d))
            (at end (not (tracking ?d)))
            (at end (tracked ?p))
        )
    )
(:durative-action drop_marker
        :parameters (?d - drone ?loc - location ?p - person)
        :duration (= ?duration 2)
        :condition (and 
            (over all(drone_at ?d ?loc))
            (over all (person_at ?p ?loc))
            (at start(not (marked ?p ?loc)))
            (at start(tracked ?p))
            (at start (marker_available ?d))
            (over all(not (landed ?d)))
        )
        :effect (and 
            (at start(marking ?d)) 
            (at end(not (marking ?d)))
            (at end (not (marker_available ?d)))
            (at end(marked ?p ?loc))
        )
    )
(:durative-action drop_lifevest
        :parameters (?d - drone ?loc - location ?p - person)
        :duration ( = ?duration 2)
        :condition (and
            (over all(drone_at ?d ?loc))
            (at start(person_at ?p ?loc))
            (at start(not (rescued ?p ?loc))) 
            (at start(tracked ?p))
            (at start (lifevest_available ?d))
            (over all(not (landed ?d)))
        )
        :effect (and
            (at start(rescuing ?d))
            (at end(not (rescuing ?d)))
            (at end (not (lifevest_available ?d)))
            (at end(rescued ?p ?loc))
        )
    )
(:durative-action recharge
        :parameters (?d - drone ?loc - location)
        :duration ( = ?duration (* 0.25 (- 100 (battery_charge ?d)))) 
        :condition (and
            (over all(drone_at ?d ?loc))
            (over all(landed ?d))
            (at start(can_recharge ?loc))
            (at start(not (battery_charged ?d))) 
        )
        :effect (and
            (at end (battery_charged ?d))
        )
    )
(:durative-action resupply
        :parameters (?d - drone ?loc - location)
        :duration ( = ?duration (+ 10 5 ))
        :condition (and
            (over all(drone_at ?d ?loc))
            (over all(landed ?d))
            (at start(can_resupply ?loc))
            (at start(not (lifevest_available ?d)))
            (at start(not (marker_available ?d)))
        )
        :effect (and
            (at end (lifevest_available ?d)) 
            (at end (marker_available ?d ))
        )
    )
)

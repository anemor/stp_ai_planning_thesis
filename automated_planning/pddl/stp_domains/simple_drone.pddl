(define (domain simple_drone)
    (:requirements 
        :strips 
        :typing 
        :fluents 
        :durative-actions 
        :negative-preconditions)
    (:types drone location)
    (:predicates
        (drone_at ?d - drone ?loc - location)
        (path ?loc_from ?loc_to - location)
        (landed ?d - drone)
    )

    (:durative-action move
        :parameters ( ?d - drone ?loc_from ?loc_to - location)
        :duration (= ?duration 5)
        :condition (and 
            (at start (path ?loc_from ?loc_to))
            (at start (drone_at ?d ?loc_from))
            (over all (not (landed ?d)))
        )
        :effect (and
            (at start (not (drone_at ?d ?loc_from)))
            (at end (drone_at ?d ?loc_to))
        )
    )
    (:durative-action land
        :parameters ( ?d - drone ?loc - location)
        :duration (= ?duration 5)
        :condition (and 
            (at start (drone_at ?d ?loc))
            (over all (not (landed ?d)))
        )
        :effect (and
            (at end (landed ?d))
        )
    )
    (:durative-action takeoff
        :parameters ( ?d - drone ?loc - location)
        :duration (= ?duration 5)
        :condition (and  (at start (drone_at ?d ?loc))
                        (at start (landed ?d))
        )
        :effect (and
            (at end (not (landed ?d)))
        )
    )
)
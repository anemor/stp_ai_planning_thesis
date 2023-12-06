(define (domain mass-ntnu)
(:requirements :typing :durative-actions)
  (:types  
     ship motor - vehicle
     vehicle car cont teamR teamF - subject
     city_location city - location
     port - city_location
     route
     )

  (:predicates
    (at ?physical_obj1 - subject ?location1 - location)
    (available ?vehicle1 - vehicle)
    (busy ?vehicle1 - vehicle)
    (waiting ?subject1 - subject)
    (delivered ?subject1 - subject)
    (loaded ?subject1 - subject ?vehicle1 - vehicle)
    (vehicle_involve ?vehicle1 - vehicle)
    (connects ?route1 - route ?location1 - location ?location2 - location)
    (in_city ?location1 - location ?city1 - city)
    (route_available ?route1 - route)
    (no_rep ?vehicle1 - vehicle)
    (repaired ?vehicle1 - vehicle)
    (no_fuel ?vehicle1 - vehicle)
    (refuel ?vehicle1 - vehicle)
    
  )

(:functions 
           (distance ?O - location ?L - location)
           (route-length ?O - route)
	 ;  (confirmation-time)
	    (speed ?V - vehicle)
            )


 (:durative-action repair-ship
       :parameters ( ?V - ship ?L - port ?K - teamR)
       :duration (= ?duration 60)
       :condition (and 
            (at start (at ?V ?L))
            (at start (at ?K ?L))
            (at start (no_rep ?V))
       )
       :effect (and 
            (at start (not (no_rep ?V)))
            (at start (repaired ?V))
        )
    )


 (:durative-action refuel-ship
       :parameters ( ?V - ship ?L - port ?Y - teamF)
       :duration (= ?duration 80)
       :condition (and 
            (at start (at ?V ?L))
            (at start (at ?Y ?L))
            (at start (no_fuel ?V))
       )
       :effect (and 
            (at start (not (no_rep ?V)))
            (at start (refuel ?V))
        )
    )




  (:durative-action move-ship
       :parameters ( ?V - vehicle ?O - location ?City - city ?L - location ?City1 - city ?R - route)
       :duration (= ?duration (/ (route-length ?R) (speed ?V)))
       :condition (and 
			(at start (at ?V ?O))
            		(at start (in_city ?O ?City))
            		(at start (in_city ?L ?City1))
            		(at start (connects ?R ?City ?City1))
       )
       :effect (and 
		  (at start (not (at ?V ?O)))
                  (at end (at ?V ?L))
        )
    )

 (:durative-action load-cont
       :parameters ( ?V - ship ?L - port ?P - cont)
       :duration (= ?duration 60)
       :condition (and 
            (over all (at ?V ?L))
            (at start (at ?P ?L))
	    (at start (available ?V))
       )
       :effect (and 
            (at start (not (available ?V)))
            (at start (busy ?V))
	    (at start (not (at ?P ?L)))
            (at end (loaded ?P ?V))
        )
    )


  (:durative-action unload-cont
       :parameters ( ?P - cont ?L - port ?V - ship )
       :duration (= ?duration 50)
       :condition (and 
       	    (over all (at ?V ?L))
            (at start (loaded ?P ?V))
	    (at start (busy ?V))
       )
       :effect (and 
            (at start (not (loaded ?P ?V)))
	    (at end (at ?P ?L))
            (at start (not (busy ?V)))
            (at end (available ?V))
        )
    )





)

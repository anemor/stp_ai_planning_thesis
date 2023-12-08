# Automated planning using STP

To run the planner on a simple scenario:
```
#python2.7 stp/temporal-planning/bin/plan.py stp-4 pddl/domains/sar_simple.#pddl pddl/problems/sar_simple_scenario.pddl

cd ~/colcon_ws/stp_ai_planning_thesis/stp
source bin/activate

python2.7 bin/plan.py stp-4 ../../pddl/domains/sar_simple.pddl ../../pddl/problems/sar_simple_scenario.pddl 
```

```
python2.7 stp/temporal-planning/bin/plan.py stp-2 ~/project_thesis/stp_ai_planning_thesis/pddl/domains/sar_simple.pddl ~/project_thesis/stp_ai_planning_thesis/pddl/problems/sar_simple_scenario.pddl

Domains that should work:
python2.7 stp/temporal-planning/bin/plan.py stp-4 stp/temporal-planning/domains/Cushing/domain/domain.pddl stp/temporal-planning/domains/Cushing/problems/pfile5.pddl

AllenAlgebra (stp-4)

```


### Plot data
```
# move plan to plans directory, edit plot_plans.py 
python3 ~/colcon_ws/src/stp_ai_planning_thesis/plans/plot_plans.py
```
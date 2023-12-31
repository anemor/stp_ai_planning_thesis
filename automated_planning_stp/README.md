# Automated planning
### Dependencies:
  - plansys2
  - anafi_uav_interfaces

### Build:
``` bash
colcon build --packages-select automated_planning_stp
```

### Run:
Terminal 1: 
``` bash
ros2 launch automated_planning_stp launch.py
```

Terminal 2: 
``` bash
ros2 run automated_planning_stp mission_controller_node --ros-args --params-file ~/colcon_ws/install/automated_planning_stp/share/automated_planning_stp/config/mission_parameters.yaml --params-file ~/colcon_ws/install/automated_planning_stp/share/automated_planning_stp/config/config.yaml

ros2 run automated_planning mission_controller_node --ros-args --params-file ~/colcon_ws/install/automated_planning/share/automated_planning/config/mission_parameters.yaml --params-file ~/colcon_ws/install/automated_planning/share/automated_planning/config/config.yaml

```

Terminal 3: To start planner when no battery or state is received:

``` bash
ros2 topic pub -t 3 /anafi/battery std_msgs/msg/Float64 '{data: "100"}'
ros2 topic pub -t 3 /anafi/state std_msgs/msg/String "{data: 'FS_LANDED'}"
```

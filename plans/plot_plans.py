import re
import matplotlib.pyplot as plt

# filename = "3_detection_1drone/tmp_sas_plan.2"
filename = "4c_simple_search_2drones_newmap/tmp_sas_plan.2"

actions = []
move_actions_d0 = set()  
move_actions_d1 = set()
# takeoff_d0 = set()
# takeoff_d1 = set()
# land_d0 = set()
# land_d1 = set()


with open(filename, "r") as file:
    for line in file:
        # regex sure is some magic<3
        match = re.match(r"([\d.]+): \(([^)]+)\) \[([\d.]+)\]", line)
        if match:
            start_time = float(match.group(1))
            action = match.group(2)
            duration = float(match.group(3))

            # Check if the action contains the word "move"
            if "move d0" in action:
                move_actions_d0.add((start_time, duration))
            elif "move d1" in action:
                move_actions_d1.add((start_time, duration))
            # elif "takeoff d0" in action:
            #     takeoff_d0.add((start_time, action, duration))
            # elif "takeoff d1" in action:
            #     takeoff_d1.add((start_time, action, duration))
            # elif "land_d0 d0" in action:
            #     land_d0.add((start_time, action, duration))
            # elif "land_d1 d0" in action:
            #     land_d1.add((start_time, action, duration))
            else:
                actions.append((start_time, action, duration))


action_colors = {
    'takeoff': 'khaki',
    'move': 'lightseagreen',
    'search': 'coral',
    'land': 'seagreen',
    'communicate': 'lightgreen',
    'track': 'orangered',
    'drop_marker': 'royalblue',
    'drop_lifevest': 'royalblue',
    'recharge': 'royalblue'
}

# Plotting
fig, ax = plt.subplots(figsize=(13, 5))

labels = []
# Plot all unique actions from the bottom
y_value = 0
if move_actions_d0:
    min_start_time = min(start_time for start_time, _ in move_actions_d0)
    max_duration = max(duration for _, duration in move_actions_d0)
    # y_value = 0  # Place "move" actions at the bottom
    labels.append("move d0")
    for start_time, duration in move_actions_d0:
        color = action_colors.get('move')
        ax.broken_barh([(start_time, duration)], (y_value, 1), facecolors=color, edgecolor='black')

if move_actions_d1:
    min_start_time = min(start_time for start_time, _ in move_actions_d1)
    max_duration = max(duration for _, duration in move_actions_d1)
    y_value += 1
    labels.append("move d1")
    for start_time, duration in move_actions_d1:
        color = action_colors.get('move')
        ax.broken_barh([(start_time, duration)], (y_value, 1), facecolors=color, edgecolor='black')

# Plot other actions on separate lines
for idx, action_data in enumerate(actions):
    if action_data not in move_actions_d0 and action_data not in move_actions_d1:
        y_value += 1  # Increment y_value for each other action
        start_time, action, duration = action_data
        color = action_colors.get(action.split()[0], 'gray')
        ax.broken_barh([(start_time, duration)], (y_value, 1), facecolors=color, edgecolor='black')

# y_value += 
# Customize the plot
ax.grid()
ax.set_yticks(range(y_value+1)) 
ax.set_yticklabels(["move d0", "move d1"] + [f"{action}" for start_time, action, duration in actions], fontsize=12)
ax.tick_params(axis='x', labelsize=12)

ax.set_xlabel('Time [s]')
# ax.set_title('Search of ')

fig.savefig('final_plots/plot4b.png', dpi=100)

plt.show()

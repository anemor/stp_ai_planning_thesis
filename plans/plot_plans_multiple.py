import re
import matplotlib.pyplot as plt

# filename = "sar_simple_stp234_tmp_sas_plan.2"
filename = "sar_simple_2drones.2"

actions_d1 = []
actions_d2 = []

with open(filename, "r") as file:
    for line in file:
        match = re.match(r"([\d.]+): \( (\w+) ([^)]+) \) \[([\d.]+)\]", line)
        if match:
            start_time = float(match.group(1))
            drone = match.group(2)
            action = match.group(3)
            duration = float(match.group(4))

            if 'd1' in drone:
                actions_d1.append((start_time, action, duration))
            elif 'd2' in drone:
                actions_d2.append((start_time, action, duration))

action_colors = {
    'takeoff': 'khaki',
    'move': 'lightseagreen',
    'search': 'coral',
    'land': 'seagreen'
}

# Create subplots
fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True, figsize=(10, 6))

# Plotting for drone d1
for idx, action_data in enumerate(actions_d1):
    start_time, action, duration = action_data
    color = action_colors.get(action.split()[0], 'gray') 
    ax1.broken_barh([(start_time, duration)], (idx, 1), facecolors=color, edgecolor='black')
ax1.set_yticks(range(len(actions_d1)))
ax1.set_yticklabels([f"{action}" for start_time, action, duration in actions_d1])
ax1.set_title('Actions Timeline - Drone d1')

# Plotting for drone d2
for idx, action_data in enumerate(actions_d2):
    start_time, action, duration = action_data
    color = action_colors.get(action.split()[0], 'gray') 
    ax2.broken_barh([(start_time, duration)], (idx, 1), facecolors=color, edgecolor='black')
ax2.set_yticks(range(len(actions_d2)))
ax2.set_yticklabels([f"{action}" for start_time, action, duration in actions_d2])
ax2.set_xlabel('Time (seconds)')
ax2.set_title('Actions Timeline - Drone d2')

plt.show()

import re
import matplotlib.pyplot as plt

filename = "sar_simple_stp234_tmp_sas_plan.2"
# filename = "sar_simple_2drones.2"

actions = []
with open(filename, "r") as file:
    for line in file:
        # regex sure is some magic<3
        match = re.match(r"([\d.]+): \(([^)]+)\) \[([\d.]+)\]", line)
        if match:
            start_time = float(match.group(1))
            action = match.group(2)
            duration = float(match.group(3))
            actions.append((start_time, action, duration))

action_colors = {
    'takeoff': 'khaki',
    'move': 'lightseagreen',
    'search': 'coral',
    'land': 'seagreen'
}

# Plotting
fig, ax = plt.subplots()

for idx, action_data in enumerate(actions):
    start_time, action, duration = action_data
    color = action_colors.get(action.split()[0], 'gray') 
    ax.broken_barh([(start_time, duration)], (idx, 1), facecolors=color, edgecolor='black')

# Customize the plot
ax.grid()
ax.set_yticks(range(len(actions)))
ax.set_yticklabels([f"{action}" for start_time, action, duration in actions])
ax.set_xlabel('Time (seconds)')
ax.set_title('Actions Timeline')

plt.show()
import matplotlib.pyplot as plt
from datetime import datetime
import re

# Function to parse the timestamp and extract seconds
def parse_timestamp(timestamp_str):
    timestamp = datetime.strptime(timestamp_str, "%S.%f")
    return timestamp.second + timestamp.microsecond / 1e6

# Read the data from the file
file_path = 'sar_simple_stp234_tmp_sas_plan.2'
with open(file_path, 'r') as file:
    lines = file.readlines()

# Lists to store data
start_times = []
durations = []
actions = []

# Regular expression to extract data from each line
pattern = re.compile(r"(\d+\.\d+): \( ([^\)]+) \) \[([\d.]+)\]")

# Parse each line and extract data
for line in lines:
    match = pattern.match(line)
    if match:
        timestamp_str, action, duration = match.groups()
        start_times.append(parse_timestamp(timestamp_str))
        durations.append(float(duration))
        actions.append(action)

# Group actions containing "move"
grouped_actions = []
grouped_durations = []

current_move_start = None
current_move_duration = 0

for start, duration, action in zip(start_times, durations, actions):
    if "move" in action:
        if current_move_start is None:
            current_move_start = start
        current_move_duration += duration
    else:
        if current_move_start is not None:
            grouped_actions.append("move")
            grouped_durations.append(current_move_duration)
            current_move_start = None
            current_move_duration = 0

        grouped_actions.append(action)
        grouped_durations.append(duration)

# Add any remaining move duration as a single bar
if current_move_start is not None:
    grouped_actions.append("move")
    grouped_durations.append(current_move_duration)

# Plotting the data
fig, ax = plt.subplots(figsize=(10, 4))

# Iterate through grouped actions and plot bars with higher zorder
for start, duration, action in zip(start_times, grouped_durations, grouped_actions):
    ax.barh(action, width=duration, left=start, zorder=2)

# Customize the plot
ax.set_xlabel('Time (seconds)')
ax.set_ylabel('Actions')
ax.set_title('Actions Over Time')

# Add grid with lower zorder
ax.grid(zorder=1)

plt.show()
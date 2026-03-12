#!/bin/bash

# Define the pattern to identify the scratchpad process
# We look for wezterm-gui running with the specific class argument
PATTERN="wezterm-gui.*--class scratchpad"

# Find the PIDs of matching processes
# -f matches against the full command line
PIDS=$(pgrep -f "$PATTERN")

if [ -n "$PIDS" ]; then
    # Process exists, kill it/them
    # We use SIGTERM (default) which allows the window to close gracefully
    echo "$PIDS" | xargs kill
else
    # Process does not exist, launch it
    # We use nohup and disown to ensure it detaches properly if needed, though usually not strictly necessary for shortcuts
    # --class sets the app_id for the window rule
    # zellij attach -c ensures we connect to the persistent session
    wezterm --config initial_cols=120 --config initial_rows=30 --config enable_tab_bar=false start --class scratchpad --workspace scratchpad -- zellij attach -c scratchpad
fi
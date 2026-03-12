#!/bin/bash

# Check if fuzzel is running
if pgrep -x "fuzzel" > /dev/null; then
    # If running, kill it
    killall fuzzel
else
    # Launch clipboard history with fuzzel
    cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
fi
#!/bin/bash

# Define the clear all option text
CLEAR_OPT="!! CLEAR ALL HISTORY !!"

# Fetch history, prepend the Clear All option
# Use fuzzel in dmenu mode. 
# We rely on fuzzel.ini for styling/sizing.
SELECTED=$( (echo "$CLEAR_OPT"; cliphist list) | fuzzel --dmenu --prompt="DELETE ENTRY: " )

# Check if user cancelled
if [[ -z "$SELECTED" ]]; then
    exit 0
fi

if [[ "$SELECTED" == "$CLEAR_OPT" ]]; then
    # Confirmation prompt
    CONFIRM=$(echo -e "No\nYes" | fuzzel --dmenu --prompt="Are you sure? Clear ALL history? " --lines=3 --width=40)
    
    if [[ "$CONFIRM" == "Yes" ]]; then
        cliphist wipe
        notify-send "Clipboard" "History cleared successfully."
    fi
else
    # Delete the specific item
    echo "$SELECTED" | cliphist delete
    notify-send "Clipboard" "Item deleted from history."
fi
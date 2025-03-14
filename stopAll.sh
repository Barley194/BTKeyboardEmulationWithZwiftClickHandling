#!/bin/bash

# Start the BT keyboard server inside a tmux session
TMUX_NAME="keyboardEmulationAndZwiftClickHandling"

# Check if the tmux session already exists
tmux has-session -t $TMUX_NAME 2>/dev/null

if [ $? == 0 ]; then
  echo "Stopping tmux session $TMUX_NAME ..."
  tmux kill-session -t $TMUX_NAME
fi

echo "Stopping Bluetooth service..."
sudo systemctl stop bluetooth


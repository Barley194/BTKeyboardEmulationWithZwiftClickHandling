#!/bin/bash

#Stop the background process
sudo hciconfig hci0 down
sudo systemctl daemon-reload
sudo /etc/init.d/bluetooth start

#Get current Path
export C_PATH=$(pwd)

# Update  mac address
./keyboardEmulation/updateMac.sh

#Update Name
./keyboardEmulation/updateName.sh RpiVirtualKeyboard

#Update which keyboard keys the zwift click will emulate
./zwift_click_handling/changePlusButtonKey.sh K
./zwift_click_handling/changeMinusButtonKey.sh I

# Start the BT keyboard server inside a tmux session
TMUX_NAME="keyboardEmulationAndZwiftClickHandling"

# Check if the tmux session already exists
tmux has-session -t $TMUX_NAME 2>/dev/null

# If the session exists, kill it
if [ $? == 0 ]; then
  echo "Session $TMUX_NAME already exists. Destroying it..."
  tmux kill-session -t $TMUX_NAME
fi

tmux new-session -d -s $TMUX_NAME
tmux split-window -h
tmux send-keys -t $TMUX_NAME:0.0 "cd $C_PATH/keyboardEmulation/server" C-m
tmux send-keys -t $TMUX_NAME:0.0 "./btk_server.py" C-m

tmux send-keys -t $TMUX_NAME:0.1 "su $SUDO_USER" C-m
tmux send-keys -t $TMUX_NAME:0.1 "cd $C_PATH/zwift_click_handling" C-m
tmux send-keys -t $TMUX_NAME:0.1 "sudo -E poetry run python app.py" C-m

tmux attach -t $TMUX_NAME

echo "Bluetooth keyboard server started in tmux session: $TMUX_NAME"
echo "Use 'sudo tmux attach -t $TMUX_NAME' to attach."
echo "Use Ctrl+b+d to detach"

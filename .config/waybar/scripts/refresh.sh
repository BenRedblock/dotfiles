#!/usr/bin/env bash
source $HOME/.config/waybar/python/venv/bin/activate
# Check if waybar is running
if pgrep -x "waybar" > /dev/null; then
    # If running, kill the waybar process
    pkill -x "waybar"
else
    # If not running, start waybar
    waybar &
fi

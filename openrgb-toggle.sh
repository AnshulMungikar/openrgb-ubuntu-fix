#!/bin/sh

# Replace 'yourusername' with your actual Ubuntu username
USER_NAME="yourusername"
USER_HOME="/home/$USER_NAME"

case "$1" in
    pre)
        # Actions to run BEFORE the PC suspends
        sudo -u "$USER_NAME" DISPLAY=:0 XAUTHORITY="$USER_HOME/.Xauthority" openrgb --profile off
        ;;
    post)
        # Actions to run AFTER the PC wakes up
        sleep 2 # Brief pause to let USB controllers initialize
        sudo -u "$USER_NAME" DISPLAY=:0 XAUTHORITY="$USER_HOME/.Xauthority" openrgb --profile default
        ;;
esac

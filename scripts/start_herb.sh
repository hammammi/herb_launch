#!/bin/bash
# Start HERB functionality in screen sessions
# Mike Dawson-Haggerty 10/8/2014
# to kill all sessions: killall -15 screen

function launcher {
    if screen -ls | grep -q $1; then
        echo "WARNING! $1 is already running!"
    else
        screen -d -S $1 -m bash
        screen -S $1 -p 0 -X stuff "source /home/herb_home/shared/herb0_ws/devel/setup.bash; $2$(printf \\r)"
    fi
}

function pr_launcher {
    launcher $1 "roslaunch herb_launch $2 --wait"
}

launcher    "core"         "roscore"
pr_launcher "state_pub"    "state_publisher.launch"
pr_launcher "ros_control"  "ros_control.launch"
pr_launcher "apriltags"    "apriltags.launch"
pr_launcher "joystick"     "joystick.launch"
pr_launcher "segway"       "segway.launch"
pr_launcher "localization" "localization.launch"
pr_launcher "navigation"   "navigation.launch"

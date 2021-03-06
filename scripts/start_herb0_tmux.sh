#!/bin/bash
# Start HERB functionalities in tmux sessions
# to kill all sessions:      pkill -f tmux
# to attach to a session:    tmux a -t <session_name>
# to detach from a session:  <ctrl + b> + d

function launcher {
    tmux has-session -t $1 2>/dev/null
    if [ "$?" -eq 0 ] ; then
        echo "WARNING! $1 is already running! (tmux session)"
    elif screen -ls | grep -q $1 ; then
        echo "WARNING! $1 is already running! (screen session)"
    else
        echo "Creating a new tmux session: $1"
	tmux new-session -d -s $1
	tmux send -t $1 "source $(catkin locate)/devel/setup.bash && $2$(printf \\r)"
    fi
}

function pr_launcher {
    launcher $1 "roslaunch herb_launch $2 --wait"
}

export ROS_MASTER_URI=http://herb2:11311/

cd /home/herb_admin/herb0_ws/

pr_launcher "ros_control" "ros_control.launch"


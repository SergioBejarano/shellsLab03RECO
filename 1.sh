#!/bin/bash
# Verify the number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: <task_name> <periodicity>"
    exit 1;
fi

task=$1
periodicity=$2

# Check if the task exists
if ! [ -x "$(command -v $task)" ]; then
    echo "Error: the command $task does not exist"
    exit 1
fi

$task & 
pid=$!

# Add the task to the user's crontab
(crontab -l 2>/dev/null; echo "$periodicity $task") | crontab -

echo "Task '$task' scheduled with periodicity '$periodicity'"
echo "Process ID: $pid"

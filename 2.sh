#!/bin/bash

option=0;

# Loop until the user selects option 5 (Exit)
while [ $option != 5 ]; do
    # Display menu to the user
    echo "1) List Running Processes"
    echo "2) Search a Process"
    echo "3) Kill/Close a Process"
    echo "4) Reload a Process"
    echo "5) Exit"
    read option 
    clear

    if [ $option != 5 ]; then
        case $option in 
            1) # List all running processes with key information
                ps aux | awk '{print $2," ",$3," ",$4," ",$11}' | less
                ;;
            2) # Search for a specific process by name
                read -p "Enter the process name: " name
                # Verify that the provided name is valid
                if [ -z "$name" ]; then
                    echo "Please enter a valid process name"
                else
                    ps -ef | grep "$name" | less
                fi
                ;;
            3) # Kill a running process
                read -p "Enter process ID (If you don't remember, press enter): " id
                if [ -z "$id" ]; then	
                    read -p "Enter the process name to kill: " name
                    if [ -z "$name" ]; then
                        echo "Please enter a valid process name"
                    else
                        # Kill the process by name
                        pkill "$name"
                        verify_name=$(ps -ef | grep "$name" | grep -v grep)
                        if [ -z "$verify_name" ]; then
                            echo "Process $name killed"
                        else
                            echo "Could not kill $name"
                        fi 
                    fi
                else
                    # Kill the process by ID
                    kill "$id"
                    verify_id=$(ps -p "$id" -o comm=)
                    if [ -z "$verify_id" ]; then
                        echo "Process $id killed"
                    else
                        echo "Could not kill process $id"
                    fi
                fi
                ;;
            4) # Restart a running process
                read -p "Enter the process ID to restart (If you don't remember, press enter): " id
                if [ -z "$id" ]; then
                    read -p "Enter the process name: " name
                    # Find the process ID by name
                    id=$(pgrep -f "$name")
                fi
                clear
                # Verify that the process ID is valid
                if [ -z "$id" ]; then
                    echo "Process not found"
                else
                    # Save the process command before killing it
                    actual_name=$(ps -p "$id" -o cmd=)
                    if [[ ! -z "$actual_name" ]]; then
                        kill "$id"
                        echo "Restarting process $id..."
                        sleep 1
                        echo "..."
                        sleep 1
                        echo "..."
                        eval "$actual_name &"
                        new_id=$(pgrep -f "$actual_name")
                        echo "Process $actual_name restarted with ID $new_id"
                    fi
                fi
                ;;
            *)
                echo "Invalid option."
                ;;
        esac
    fi
done

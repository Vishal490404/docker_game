#!/bin/bash

# Function to display a progress bar
progress_bar() {
    local percentage=$1
    local length=50
    local cols=80  # Default number of columns
    local spaces=$(( (cols - length - 10) / 2 ))  # Center the progress bar

    # Print progress bar
    printf "\r["
    local progress=$(( percentage * length / 100 ))
    for ((i=0; i<progress; i++)); do 
        printf "=" 
        sleep 0.02
    done
    for ((i=progress; i<length; i++)); do printf " "; done
    printf "] %3d%%" "$percentage"
    printf "%*s\n" "$spaces" " "
}

visited=(0 0 0 0 0 0)
echo ""
echo "Task List"
# Check if Task-1 is completed
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^alpine:3.17$"; then
    visited[0]=1
    echo "Great!! Task-1 is completed."
    # progress_bar 20
else
    echo "Incomplete Task-1"
fi

# check if task-2 is completed
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^alpine:49.04$" && [ "${visited[0]}" -eq 1 ]; then 
    visited[1]=1
    echo "Great!! Task-2 is completed."
    # progress_bar 60
else
    echo "Incomplete Task-2"
fi


# check if task-3 is completed
if docker ps -a --format '{{.Names}}' | grep -q "^alphabetameta$" && [ "${visited[1]}" -eq 1 ]; then
    container_image=$(docker inspect -f '{{.Config.Image}}' alphabetameta)
    expected_image="busybox"

    if [ "$container_image" == "$expected_image" ]; then
        visited[2]=1
        echo "Great!! Task-3 is completed, container creation completed successfully with the correct image."
        # progress_bar 80
    elif [ "$container_image" != "$expected_image" ]; then
        echo "Container creation failed. Incorrect image used. Expected: $expected_image, Actual: $container_image"
    else
        echo "Incomplete Task-3"
    fi
else
    echo "Incomplete Task-3"
fi

# check if task-4 is completed
if docker ps -a --format '{{.Names}}' | grep -q "^alphabetameta$" && [ "${visited[2]}" -eq 1 ]; then
    if docker ps -a --format '{{.Names}} {{.Status}}' | grep -q "^alphabetameta Up"; then
        visited[3]=1
        echo "Great!! Task-4 is completed."
        # progress_bar 100
    else
        echo "Incomplete Task-4"
    fi

else
    echo "Incomplete Task-4"
fi

# check if task-5 is completed
if docker ps -a --format '{{.Names}}' | grep -q "^alphabetameta$" && [ "${visited[3]}" -eq 1 ]; then

    # Check if the meta2k24 image is created
    if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^meta2k24:latest$"; then
        visited[4]=1
        echo "Great!! Task-5 is completed."
        # progress_bar 100
    else
        echo "Incomplete Task-5"
    fi
else
    echo "Incomplete Task-5"
fi



# check if task-6 is completed
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^busybox:latest$" && [ "${visited[4]}" -eq 1 ]; then 
    echo "Incomplete task-6"
    # progress_bar 100
elif  [ "${visited[4]}" -eq 1 ]; then
    visited[5]=1
    echo "Great!! Task-6 is completed."
else
    echo "Incomplete Task-6"
fi

echo ""
echo "Progress"
if [ "${visited[0]}" -eq 0 ]; then
    echo "You have not started yet"
elif [ "${visited[0]}" -eq 1 ] && [ "${visited[1]}" -eq 0 ]; then
    echo "You are 10% there"
    progress_bar 10
elif [ "${visited[1]}" -eq 1 ] && [ "${visited[2]}" -eq 0 ]; then
    echo "You are 20% there"
    progress_bar 20
elif [ "${visited[2]}" -eq 1 ] && [ "${visited[3]}" -eq 0 ]; then
    echo "You are 35% there"
    progress_bar 35
elif [ "${visited[3]}" -eq 1 ] && [ "${visited[4]}" -eq 0 ]; then
    echo "You are 70% there"
    progress_bar 70
elif [ "${visited[4]}" -eq 1 ] && [ "${visited[5]}" -eq 0 ]; then
    echo "You are 80% there"
    progress_bar 80
elif [ "${visited[5]}" -eq 1 ]; then
    echo "You made it"
    progress_bar 100
fi

if [ "${visited[5]}" -eq 1 ]; then
    echo "Now that you have come so far, find the flag which is hidden in the text file."
    echo "WLUG{aqspd7443e}" > not_a_flag.txt
fi

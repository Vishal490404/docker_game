#!/bin/bash

# If docker not in machine install docker

if command -v "docker" &> /dev/null; then
    echo "Docker already exists"
else
    clear
    echo "Please wait...."
    echo "Updating...."
    sudo apt update &> /dev/null
    echo "Installing Docker....."
    sudo snap install docker &> /dev/null
    echo "Done."
fi

if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^wildwarrior44/the_game_iamge:latest$"; 
then
    echo "Level already exists"
else
    echo "Pulling level..."
    docker pull wildwarrior44/the_game_iamge &> /dev/null
fi

docker run --hostname wlug --user root -v /var/run/docker.sock:/var/run/docker.sock -it --name the_game wildwarrior44/the_game_image /bin/bash


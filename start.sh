#!/bin/bash

# If docker not in machine install docker

if command -v "docker" &> /dev/null; then
    echo "Docker already exists"
else
    release_notes = /etc/os-release
    if grep -q "Ubuntu" $release_notes
    then
        clear
        echo " Please wait... "
        sudo apt update && sudo apt upgrade &> /dev/null
        sudo apt install docker &> /dev/null
    fi
fi

if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^wildwarrior44/the_game_iamge:latest$"; 
then
    echo "Level already exists"
else
    echo "Pulling level..."
    docker pull wildwarrior44/the_game_iamge &> /dev/null
fi

docker run --hostname wlug --user root -v /var/run/docker.sock:/var/run/docker.sock -it --name the_game wildwarrior44/the_game_image /bin/bash


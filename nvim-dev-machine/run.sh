#!/bin/bash

CONTAINER_NAME="my-dev-container"
IMAGE_NAME="nvim-dev-machine" # Make sure this matches your image name


echo "[Run] Check if the container exists and is running"

if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
  echo "[Run] Check if the container exists but is stopped (not running)"

  if [[ "$(docker ps -aq -f name=$CONTAINER_NAME)" != "" ]]; then
    echo "[Run] Starting container"

    docker start $CONTAINER_NAME
    if [ $? -ne 0 ]; then
      echo "ERROR: Failed to start container '$CONTAINER_NAME'."
      exit 1
    fi
  else
    echo "[Run] Creating new container to start"
    HOST_UID=$(id -u)
    HOST_GID=$(id -g)
    WAYLAND_DISPLAY=$WAYLAND_DISPLAY
    XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR

    # Replace these with your actual run command parameters
    # This is a placeholder for your specific volume mounts, ports, etc.
    docker run -d --add-host metadata.google.internal:127.0.0.1 --user $HOST_UID:$HOST_GID --env WAYLAND_DISPLAY=$WAYLAND_DISPLAY --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY --name $CONTAINER_NAME --privileged --net=host -P -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/repo $IMAGE_NAME:latest

    if [ $? -ne 0 ]; then
      echo "ERROR: Failed to create and run container '$CONTAINER_NAME'."
      exit 1
    fi
  fi

  bash nvim-dev-machine/enter-on-startup.sh
else
  bash nvim-dev-machine/enter.sh
fi

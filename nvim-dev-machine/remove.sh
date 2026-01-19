#!/bin/bash

CONTAINER_NAME="my-dev-container"
IMAGE_NAME="neovim-dev-machine" # Make sure this matches your image name

docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker image rm $IMAGE_NAME

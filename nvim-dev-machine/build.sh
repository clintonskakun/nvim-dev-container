#!/bin/bash

IMAGE_NAME="nvim-dev-machine" # The name of your image

# Check if the image exists locally
echo "[Build] Check if image exists locally"

if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "[Build] Building image"
  # Replace 'Dockerfile' with the actual path to your Dockerfile if it's not in the same directory
  # Replace '.' with the build context if it's different
  docker build --add-host metadata.google.internal:127.0.0.1 -t $IMAGE_NAME . -f nvim-dev-machine/Dockerfile

  if [ $? -ne 0 ]; then
    echo "ERROR: Image '$IMAGE_NAME' build failed."
    exit 1 # Exit with an error code if build fails
  fi
fi

#!/bin/bash

CONTAINER_NAME="my-dev-container"

# Always attempt to enter. docker exec will fail if the container is not running.
echo "[Enter] Entering container" 
docker exec -it $CONTAINER_NAME bash -c 'nvim-dev-machine/init-enter.sh' # Or sh, or whatever your container's shell is

if [ $? -ne 0 ]; then
  echo "ERROR: Failed to enter container '$CONTAINER_NAME'. Is it running?"
  exit 1
fi

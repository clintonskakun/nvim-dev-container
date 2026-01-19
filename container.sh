#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

# --- Check if the user is root ---
if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run as root (or with sudo)."
  echo "Please try again with: sudo bash nvim-dev-machine/build.sh"
  exit 1
fi
# --- End of root check ---

# Define your Docker image and container names
IMAGE_NAME="nvim-dev-machine"
CONTAINER_NAME="my-dev-container" # This should match what you use in run.sh

REBUILD=false

# Check if --rebuild argument is provided
if [ "$1" == "--rebuild" ]; then
    REBUILD=true
    shift # Remove the --rebuild argument so it doesn't interfere with docker build
fi

# --- Handle the --rebuild logic ---
if [ "$REBUILD" = true ]; then
    echo "--- Rebuild requested ---"
    read -p "WARNING: This will stop and remove the container ('$CONTAINER_NAME') and delete the Docker image ('$IMAGE_NAME'). All data inside the container will be removed. Are you sure? (y/N): " confirm

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "Rebuild cancelled. Exiting."
        exit 1 # Exit if the user doesn't confirm
    fi

    echo "Attempting to stop and remove existing container..."
    # Stop and remove the container if it exists.
    # 'docker stop' might fail if the container isn't running. '|| true' ignores the error.
    # 'docker rm' might fail if the container doesn't exist. '2>/dev/null' suppresses errors.
    docker stop "$CONTAINER_NAME" 2>/dev/null || true
    docker rm "$CONTAINER_NAME" 2>/dev/null || true
    echo "Container removed if it existed."

    echo "Attempting to remove existing image..."
    # Remove the Docker image. 'docker rmi' will fail if a container is still using it,
    # which is why we stop/remove the container first.
    docker rmi "$IMAGE_NAME" 2>/dev/null || true
    echo "Image removed if it existed."
    echo "--- Rebuild cleanup complete ---"
fi


bash nvim-dev-machine/build.sh && bash nvim-dev-machine/run.sh 

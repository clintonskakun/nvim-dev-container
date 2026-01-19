#!/bin/bash

source ~/.bashrc
# Define the "placeholder" defaults we want to force a change from
PLACEHOLDER_NAME="Your Name Here"
PLACEHOLDER_EMAIL="your.email@example.com"

echo "[Init Enter] Verify basic git setup"
# --- Git User Name ---
CURRENT_GIT_USER_NAME=$(git config --global user.name)
PROMPT_FOR_NAME=false

if [ -z "$CURRENT_GIT_USER_NAME" ]; then
    echo "Current Git user.name: Not set"
    PROMPT_FOR_NAME=true
elif [ "$CURRENT_GIT_USER_NAME" = "$PLACEHOLDER_NAME" ]; then
    echo "Current Git user.name: '$CURRENT_GIT_USER_NAME' (placeholder detected)"
    PROMPT_FOR_NAME=true
fi

if [ "$PROMPT_FOR_NAME" = true ]; then
    read -p "Please enter your full name: " USER_NAME_INPUT
    if [ -n "$USER_NAME_INPUT" ]; then # Ensure they actually entered something
        git config --global user.name "$USER_NAME_INPUT"
        echo "✅ Git user.name set to: $(git config --global user.name)"
    else
        echo "❌ No name entered. Git user.name remains unchanged or empty."
	exit 1
    fi
fi

# --- Git User Email ---
CURRENT_GIT_USER_EMAIL=$(git config --global user.email)
PROMPT_FOR_EMAIL=false

if [ -z "$CURRENT_GIT_USER_EMAIL" ]; then
    echo "Current Git user.email: Not set"
    PROMPT_FOR_EMAIL=true
elif [ "$CURRENT_GIT_USER_EMAIL" = "$PLACEHOLDER_EMAIL" ]; then
    echo "Current Git user.email: '$CURRENT_GIT_USER_EMAIL' (placeholder detected)"
    PROMPT_FOR_EMAIL=true
fi

if [ "$PROMPT_FOR_EMAIL" = true ]; then
    read -p "Please enter your email used in GitHub: " USER_EMAIL_INPUT
    if [ -n "$USER_EMAIL_INPUT" ]; then # Ensure they actually entered something
        git config --global user.email "$USER_EMAIL_INPUT"
        echo "✅ Git user.email set to: $(git config --global user.email)"
    else
        echo "❌ No email entered. Git user.email remains unchanged or empty."
	exit 1
    fi
fi

# --- Node.js Dependencies Check ---

INSTALL_NEEDED=false

echo "[Init Enter] Updating node modules"

bash nvim-dev-machine/update-nvim.sh

echo "Welcome! The container is ready to use."

nvim

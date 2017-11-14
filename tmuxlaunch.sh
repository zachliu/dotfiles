#!/bin/bash

# stop script if encounter errors
# prevents script from making changes to previously running session
# if one already exists
set -e

if [[ $# > 0 ]]; then
  SESSION=$1
else
  SESSION=ZL
fi

# Create session in detached mode
tmux new-session -d -s $SESSION

# Select first window
tmux select-window -t $SESSION:0

# Attach to session newly-created session
tmux attach -t $SESSION

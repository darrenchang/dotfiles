#!/bin/bash

# Check if mouse is disabled (example condition, adapt to your setup)
if [[ $(tmux show-options -g | grep mouse | grep -c off) -gt 0 ]]; then
    MOUSE=" 󰍾"
else
    MOUSE=""
fi

echo "${MOUSE}"

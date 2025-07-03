#!/bin/bash

PLATFORM=$(uname -s)

case $PLATFORM in
    'Linux')
        tmux show-buffer | sed 's/▎/ /g' | xclip -selection clipboard
        ;;
    'Darwin')
        tmux show-buffer | sed 's/▎/ /g' | pbcopy
        ;;
    *)
        echo "message"
        ;;
esac

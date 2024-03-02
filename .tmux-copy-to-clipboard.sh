#!/bin/bash

PLATFORM=$(uname -s)

case $PLATFORM in
    'Linux')
        tmux show-buffer | xclip -selection clipboard
        ;;
    'Darwin')
        tmux show-buffer | pbcopy
        ;;
    *)
        echo "message"
        ;;
esac

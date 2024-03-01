#!/bin/bash

PLATFORM=$(uname -s)

case $PLATFORM in
    'Linux')
        ICON=""
        ;;
    'Darwin')
        ICON=""
        ;;
    *)
        ICON="?"
        ;;
esac

echo "${ICON} $(hostname -s)"

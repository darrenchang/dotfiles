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

if [[ "${1}" == "no-hostname" ]]; then
    echo "${ICON} "
else
    echo "${ICON} $(hostname -s)"
fi

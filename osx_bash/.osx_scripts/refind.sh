#!/bin/bash

set -x
set -e

REFIND_DIRECTORY="/Users/${USER}/Downloads/refind/"
ACTION=$1

if [[ $ACTION == "install" ]]; then
    if [[ ! -d "$REFIND_DIRECTORY" ]]; then
        echo "Please download refind and save to \"~/Downloads\""
        exit 1
    fi
    cd $REFIND_DIRECTORY
    bash install.sh && sudo pmset -a autopoweroff 0
    cd -
elif [[ $ACTION == "remove" ]]; then
    sudo rm -rf /EFI/refind
    sudo pmset -a autopoweroff 1
else
    echo "Invalid action \"$ACTION\""
fi

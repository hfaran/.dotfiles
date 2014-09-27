#!/bin/bash

set -x

ACTION=$1

if [[ $ACTION == "install" ]]; then
	cd ~/Downloads/refind
	bash install.sh && sudo pmset -a autopoweroff 0
	cd -
elif [[ $ACTION == "remove" ]]; then
	sudo rm -rf /EFI/refind
	sudo pmset -a autopoweroff 1
else
	echo "Invalid action \"$ACTION\""
fi


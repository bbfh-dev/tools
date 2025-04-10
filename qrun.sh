#!/usr/bin/bash
# I made this script to quickly setup and run predefined commands for projects

mkdir -p ~/.config/shell/qrun/

CWD=$(pwd)
WORKSPACE="$HOME/.config/shell/qrun/$(basename $CWD)__$(echo $CWD | base64).sh"

if [[ -f $WORKSPACE ]]; then
	if [[ -n "$1" ]]; then
		rm $WORKSPACE
		echo "--- Deleted $WORKSPACE"
		exit 0
	fi
	sh $WORKSPACE
else
	touch $WORKSPACE
	echo -e "# Your background tasks:\n" > $WORKSPACE
	for i in $(seq 1 $1); do
		echo -e "PID_$i=\$!\n" >> $WORKSPACE
	done
	echo -e "# Your foreground task:\n\n" >> $WORKSPACE
	echo -e "# Kill background tasks:" >> $WORKSPACE
	for i in $(seq 1 $1); do
		echo -e "kill -9 \$PID_$i" >> $WORKSPACE
	done
	chmod +x $WORKSPACE
	nvim $WORKSPACE
fi

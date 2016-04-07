#!/bin/bash
i3status -c ~/.i3/i3status | while :
do
    read line;
    I3_ORIENTATION=$(cat /tmp/.i3_split_orientation);
    I3_ORIENTATION_STATUS=""
    if [ "$I3_ORIENTATION" == "horizontal" ] ; then
    	I3_ORIENTATION_STATUS="H"
	else
    	I3_ORIENTATION_STATUS="_"
	fi
	echo "${line/[/[{\"full_text\":\"I3Split: $I3_ORIENTATION_STATUS\"\},}" || exit 1
done

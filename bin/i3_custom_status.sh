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
    TODO_COUNT=0
	[[ -f ~/TODO/TODO ]] && TODO_COUNT=$(cat ~/TODO/TODO | wc -l)
    echo "${line/[/[{\"full_text\":\"TODO: $TODO_COUNT | I3Split: $I3_ORIENTATION_STATUS\"\},}" || exit 1
done

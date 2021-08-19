#!/bin/bash

touch /tmp/.i3_split_orientation

i3status -c ~/.config/i3status/config | while :
do
    read line;
    I3_ORIENTATION=$(cat /tmp/.i3_split_orientation);
    I3_ORIENTATION_STATUS=""
    if [ "$I3_ORIENTATION" == "horizontal" ] ; then
        I3_ORIENTATION_STATUS="I"
    else
        I3_ORIENTATION_STATUS="—"
    fi
    echo "${line/[/[{\"full_text\":\"$I3_ORIENTATION_STATUS \"\},}" || exit 1
done

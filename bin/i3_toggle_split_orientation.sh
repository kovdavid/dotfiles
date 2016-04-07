#!/bin/bash

if [ ! -f /tmp/.i3_split_orientation ] ; then
    echo -n "horizontal" > /tmp/.i3_split_orientation
    i3-msg -tcommand split horizontal
else
    ORIENTATION=$(cat /tmp/.i3_split_orientation)
    if [ "$ORIENTATION" == "horizontal" ] ; then
        echo -n "vertical" > /tmp/.i3_split_orientation
        i3-msg -tcommand split vertical
    elif [ "$ORIENTATION" == "vertical" ] ; then
        echo -n "horizontal" > /tmp/.i3_split_orientation
        i3-msg -tcommand split horizontal
    else
        echo "Wrong orientation $ORIENTATION"
    fi
fi
killall -USR1 i3status

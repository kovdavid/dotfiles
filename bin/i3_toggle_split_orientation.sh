#!/bin/bash

FILE="/tmp/.i3_split_orientation"

if [ ! -f $FILE ] ; then
    echo -n "horizontal" > $FILE
    i3-msg -tcommand split horizontal
else
    ORIENTATION=$(cat $FILE)
    if [ "$ORIENTATION" == "horizontal" ] ; then
        echo -n "vertical" > $FILE
        i3-msg -tcommand split vertical
    elif [ "$ORIENTATION" == "vertical" ] ; then
        echo -n "horizontal" > $FILE
        i3-msg -tcommand split horizontal
    else
        echo "Wrong orientation $ORIENTATION"
        rm -rf $FILE
    fi
fi

pidof i3status | xargs kill -USR1

#!/bin/bash

FILE=/tmp/dalsik.env

GUI=0
SHIFT=0
CTRL=0
ALT=0
LAYER=0
CAPS_WORD=0

if [ -f $FILE ] ; then
    source $FILE

    if [ "$CAPS_WORD" == "1" ] ; then
        echo -n "%{F#00FF00}CAPS_WORD%{F-} "
    fi

    [[ "$LAYER" -gt "0" ]] && color="E0AF68" || color="555555"
    echo -n "%{F#$color}L[$LAYER]%{F-} "

    for mod in GUI SHIFT CTRL ALT; do
        [[ "${!mod}" == "1" ]] && color="FFFFFF" || color="555555"
        echo -n "%{F#$color}$mod%{F-} "
    done
fi

echo ""

inotifywait -t 10 -e modify,delete $FILE &> /dev/null

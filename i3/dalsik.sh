#!/bin/bash

FILE=/tmp/dalsik.env

if [ -f $FILE ] ; then
    source $FILE

    if [ "$CAPS_WORD" == "1" ] ; then
        echo -n "<span color='#00FF00'>CAPS_WORD</span> "
    fi

    [[ "$LAYER" -gt "0" ]] && color="#E0AF68" || color="#555555"
    echo -n "<span color='$color'>L[${LAYER:-0}]</span> "

    for mod in GUI SHIFT CTRL ALT; do
        [[ "${!mod}" == "1" ]] && color="#FFFFFF" || color="#555555"
        echo -n "<span color='$color'>$mod</span> "
    done
fi

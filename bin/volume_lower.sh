#!/bin/bash

MASTER_VOL=$(amixer get Master | awk -F"[][]" '/dB/ { print $2 }' | sed -e 's/%//g')
PCM_VOL=$(amixer get PCM | awk -F"[][]" '/dB/ { print $2 }' | sed -e 's/%//g' | head -n 1)

if [ "$PCM_VOL" == "100" ] ; then
    amixer -q set PCM 90%
    amixer -q set Speaker 90%
    amixer -q set Headphone 90%
else
    amixer -q set Master 5%-
fi

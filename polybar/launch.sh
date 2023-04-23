#!/bin/bash

killall -q -w polybar

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$monitor polybar 2>&1 | tee -a /tmp/polybar_${monitor}.log & disown
done

echo "Polybar started..."

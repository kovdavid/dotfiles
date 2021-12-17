#!/bin/bash

killall -q polybar

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$monitor polybar --reload main 2>&1 | tee -a /tmp/polybar_${monitor}.log & disown
done

echo "Polybar started..."

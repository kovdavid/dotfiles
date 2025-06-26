#!/bin/bash

ACTION=$1

function menu_item {
    INFO=$1
    NAME=$2
    ICON=$3

    echo -en "$NAME\x00info\x1f$INFO"

    if [ -n $ICON ] ; then
        echo -en "\x1ficon\x1f$ICON"
    fi

    echo -en "\n"
}

function run_cmd {
    CMD=$1

    echo $CMD >> /tmp/rofi.log

    coproc ( $CMD  >> /tmp/rofi.log 2>&1 )
}

if [ "$ROFI_INFO" = "" ] ; then
    menu_item "main" "firefox 1990" "firefox"
    menu_item "main" "beekeeper" "beekeeper-studio"
    menu_item "main" "work session" "preferences-system"
    menu_item "main" "rquickshare" "rquickshare"
    menu_item "main" "gimp" "gimp"
elif [ "$ROFI_INFO" = "main" ] ; then
    if [ "$ACTION" = "thunar" ] ; then
        run_cmd "thunar"
    elif [ "$ACTION" = "firefox 1990" ] ; then
        run_cmd "firefox_1990"
    elif [ "$ACTION" = "beekeeper" ] ; then
        run_cmd "beekeeper-studio"
    elif [ "$ACTION" = "work session" ] ; then
        run_cmd "work_session"
    elif [ "$ACTION" = "rquickshare" ] ; then
        run_cmd "rquickshare"
    elif [ "$ACTION" = "gimp" ] ; then
        run_cmd "gimp"
    fi
fi

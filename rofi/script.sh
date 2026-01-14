#!/bin/bash

ACTION=$1

# echo "$0 $@" >> /tmp/rofi-debug.log
# echo "ROFI_INFO:$ROFI_INFO" >> /tmp/rofi-debug.log
# echo "ROFI_DATA:$ROFI_DATA" >> /tmp/rofi-debug.log
# echo "ROFI_RETV:$ROFI_RETV" >> /tmp/rofi-debug.log
# echo "ACTION:$ACTION" >> /tmp/rofi-debug.log

# Keep filter/selection if inside submenu
if [ "$ROFI_RETV" = "1" ]; then
    echo -en "\x00keep-filter\x1ftrue\n"
    echo -en "\x00keep-selection\x1ftrue\n"
fi

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

function draw_brightness_menu {
    CURRENT=$(brightnessctl --machine-readable info | cut -d ',' -f 4)

    echo -en "\x00prompt\x1f$CURRENT\n"
    menu_item "main brightness" "up" "arrow-up"
    menu_item "main brightness" "down" "arrow-down"
}

function draw_performance_menu {
    menu_item "main performance" "boost off" "cpu"
    menu_item "main performance" "powersave" "cpu"
    menu_item "main performance" "fan quiet" "preferences-system"
    menu_item "main performance" "boost on" "cpu"
    menu_item "main performance" "schedutil" "cpu"
    menu_item "main performance" "fan cool" "preferences-system"
    menu_item "main performance" "ryzenadj 65" "cpu"
    menu_item "main performance" "ryzenadj 75" "cpu"
    menu_item "main performance" "battery-saver" "cpu"
    menu_item "main performance" "normal" "cpu"
}

function draw_redshift_menu {
    # TEMP=$(redshift -p 2>/dev/null | grep 'Color temperature:' | cut -d" " -f3)
    # BRIGHTNESS=$(redshift -p 2>/dev/null | grep 'Brightness' | cut -d" " -f2)

    if [ -f /tmp/redshift_correction.cfg ] ; then
        content=$(cat /tmp/redshift_correction.cfg)
        echo -en "\x00prompt\x1f$content\n"
    fi

    menu_item "main redshift" "run" "system-run"
    menu_item "main redshift" "brightness correct up" "arrow-up"
    menu_item "main redshift" "temp correct up" "arrow-up"
    menu_item "main redshift" "disable" "system-run"
    menu_item "main redshift" "brightness correct down" "arrow-down"
    menu_item "main redshift" "temp correct down" "arrow-down"
}

if [ "$ACTION" = "quit" ] ; then
    exit 0
fi

if [ "$ROFI_INFO" = "" ] ; then
    menu_item "main" "tmux" "utilities-terminal"
    menu_item "main" "tmux_join" "utilities-terminal"
    menu_item "main" "terminal" "utilities-terminal"
    menu_item "main" "firefox" "firefox"
    menu_item "main" "thunar" "system-file-manager"
    menu_item "main" "calc" "accessories-calculator"
    menu_item "main" "keepassxc" "keepassxc"
    menu_item "main" "flameshot" "flameshot"
    menu_item "main" "full-screen (5s)" "flameshot"
    menu_item "main" "performance" "preferences-system-performance"
    menu_item "main" "Toggle color scheme" "kcolorchooser"
    menu_item "main" "power" "preferences-system-power-management"
    menu_item "main" "monitor" "preferences-desktop-display"
    menu_item "main" "redshift" "redshift"
    menu_item "main" "brightness" "video-display"
elif [ "$ROFI_INFO" = "main" ] ; then
    if [ "$ACTION" = "power" ] ; then
        menu_item "main power" "screensaver" "system-suspend"
        menu_item "main power" "sleep" "system-suspend"
        menu_item "main power" "lock" "system-lock-screen"
        menu_item "main power" "halt" "system-shutdown"
        menu_item "main power" "reboot" "system-reboot"
    elif [ "$ACTION" = "monitor" ] ; then
        menu_item "main monitor" "external monitor left" "arrow-left"
        menu_item "main monitor" "external monitor right" "arrow-right"
        menu_item "main monitor" "external monitor top" "arrow-up"
        menu_item "main monitor" "reset & external monitor left" "arrow-left"
        menu_item "main monitor" "notebook only" "computer-laptop"
        menu_item "main monitor" "external monitor only" "video-display"
    elif [ "$ACTION" = "redshift" ] ; then
        draw_redshift_menu
    elif [ "$ACTION" = "brightness" ] ; then
        draw_brightness_menu
    elif [ "$ACTION" = "tmux" ] ; then
        run_cmd "alacritty -e xterm_tmux_session"
    elif [ "$ACTION" = "tmux_join" ] ; then
        run_cmd "alacritty -e tmux_join"
    elif [ "$ACTION" = "terminal" ] ; then
        run_cmd "alacritty"
    elif [ "$ACTION" = "performance" ] ; then
        draw_performance_menu
    elif [ "$ACTION" = "thunar" ] ; then
        run_cmd "thunar"
    elif [ "$ACTION" = "flameshot" ] ; then
        FILENAME=$(date '+%FT%T.png')
        run_cmd "flameshot gui -p /clean_daily/$FILENAME"
    elif [ "$ACTION" = "keepassxc" ] ; then
        run_cmd "keepassxc"
    elif [ "$ACTION" = "full-screen (5s)" ] ; then
        FILENAME=$(date '+%FT%T.png')
        run_cmd "flameshot full -d 5000 -p /clean_daily/$FILENAME"
    elif [ "$ACTION" = "firefox" ] ; then
        run_cmd "firefox"
    elif [ "$ACTION" = "calc" ] ; then
        run_cmd "calc"
    elif [ "$ACTION" = "Toggle color scheme" ] ; then
        run_cmd "color_scheme"
    fi
elif [ "$ROFI_INFO" = "main monitor" ] ; then
    if [ "$ACTION" = "external monitor left" ] ; then
        run_cmd "mon left"
    elif [ "$ACTION" = "external monitor right" ] ; then
        run_cmd "mon right"
    elif [ "$ACTION" = "external monitor top" ] ; then
        run_cmd "mon top"
    elif [ "$ACTION" = "notebook only" ] ; then
        run_cmd "mon off"
    elif [ "$ACTION" = "reset & external monitor left" ] ; then
        run_cmd "mon off"
        sleep 3
        run_cmd "mon left"
    elif [ "$ACTION" = "external monitor only" ] ; then
        run_cmd "mon sec"
    fi
elif [ "$ROFI_INFO" = "main redshift" ] ; then
    if [ "$ACTION" = "run" ] ; then
        run_cmd "redshift_adjust.pl"
    elif [ "$ACTION" = "disable" ] ; then
        run_cmd "redshift_adjust.pl -d"
    elif [ "$ACTION" = "brightness correct up" ] ; then
        run_cmd "redshift_adjust.pl --brightness-correction-up"
    elif [ "$ACTION" = "brightness correct down" ] ; then
        run_cmd "redshift_adjust.pl --brightness-correction-down"
    elif [ "$ACTION" = "temp correct up" ] ; then
        run_cmd "redshift_adjust.pl --temp-correction-up"
    elif [ "$ACTION" = "temp correct down" ] ; then
        run_cmd "redshift_adjust.pl --temp-correction-down"
    fi
    sleep 0.1
    draw_redshift_menu
elif [ "$ROFI_INFO" = "main power" ] ; then
    if [ "$ACTION" = "screensaver" ] ; then
        run_cmd "xset dpms force off"
    elif [ "$ACTION" = "sleep" ] ; then
        run_cmd "systemctl suspend"
    elif [ "$ACTION" = "lock" ] ; then
        run_cmd "i3lock -c 333333"
    elif [ "$ACTION" = "halt" ] ; then
        run_cmd "systemctl poweroff"
    elif [ "$ACTION" = "reboot" ] ; then
        run_cmd "systemctl reboot"
    fi
elif [ "$ROFI_INFO" = "main brightness" ] ; then
    if [ "$ACTION" = "up" ] ; then
        brightnessctl --quiet set 5%+
    elif [ "$ACTION" = "down" ] ; then
        brightnessctl --quiet set 5%-
    fi
    draw_brightness_menu
elif [ "$ROFI_INFO" = "main performance" ] ; then
    RYZEN65="ryzenadj_preset 65"
    RYZEN75="ryzenadj_preset 75"
    if [ "$ACTION" = "boost off" ] ; then
        run_cmd "boost off"
    elif [ "$ACTION" = "boost on" ] ; then
        run_cmd "boost on"
    elif [ "$ACTION" = "powersave" ] ; then
        run_cmd "cpu_powersave"
    elif [ "$ACTION" = "schedutil" ] ; then
        run_cmd "cpu_schedutil"
    elif [ "$ACTION" = "fan quiet" ] ; then
        run_cmd "fan quiet"
    elif [ "$ACTION" = "fan cool" ] ; then
        run_cmd "fan cool"
    elif [ "$ACTION" = "fan cool" ] ; then
        run_cmd "fan cool"
    elif [ "$ACTION" = "ryzenadj 65" ] ; then
        run_cmd "$RYZEN65"
    elif [ "$ACTION" = "ryzenadj 75" ] ; then
        run_cmd "$RYZEN75"
    elif [ "$ACTION" = "battery-saver" ] ; then
        run_cmd "boost off"
        run_cmd "cpu_powersave"
        run_cmd "$RYZEN65"
        run_cmd "keyboard_repeat"
        run_cmd "init_touchpad"
        run_cmd "dalsik_daemon restart"
    elif [ "$ACTION" = "normal" ] ; then
        run_cmd "boost on"
        run_cmd "cpu_schedutilowersave"
        run_cmd "$RYZEN65"
        run_cmd "keyboard_repeat"
        run_cmd "init_touchpad"
        run_cmd "dalsik_daemon restart"
    fi

    draw_performance_menu
fi

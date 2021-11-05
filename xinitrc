#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

xset s 900 900
xset dpms 900 900 900

[ -f ~/dotfiles/bash/env_settings ] && source ~/dotfiles/bash/env_settings

if [ -r /etc/xprofile ]; then
    source /etc/xprofile
fi
if [ -r ~/.xprofile ]; then
    source ~/.xprofile
fi
if [ -r ~/.profile ]; then
    source ~/.profile
fi
if [ -r ~/.xsessionrc ]; then
    source ~/.xsessionrc
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
  exec ck-launch-session dbus-launch --exit-with-session /usr/bin/i3
else
  exec /usr/bin/i3
fi

#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

xset s 900 900
xset dpms 900 900 900

# keyboard auto repeat
xset r rate 300 40

[ -f ~/dotfiles/bash/env_settings ] && source ~/dotfiles/bash/env_settings

[[ -r /etc/xprofile ]] && source /etc/xprofile
[[ -r ~/.xprofile ]]   && source ~/.xprofile
[[ -r ~/.profile ]]    && source ~/.profile
[[ -r ~/.xsessionrc ]] && source ~/.xsessionrc

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

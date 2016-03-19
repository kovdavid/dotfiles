#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

xset s 1800 1800
xset dpms 1800 1800 1800

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ] && /usr/bin/xrdb -merge $sysresources
[ -f $sysmodmap ] && /usr/bin/xmodmap $sysmodmap
[ -f $userresources ] && /usr/bin/xrdb -merge $userresources
[ -f $usermodmap ] && /usr/bin/xmodmap $usermodmap

/usr/bin/xmodmap -e 'keycode 66 = Escape'
/usr/bin/xmodmap -e 'clear Lock'

if [ -r /etc/xprofile ]; then
    source /etc/xprofile
fi
if [ -r $HOME/.xprofile ]; then
    source $HOME/.xprofile
fi
if [ -r $HOME/.profile ]; then
    source $HOME/.profile
fi
if [ -r $HOME/.xsessionrc ]; then
    source /home/davs/.xsessionrc
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

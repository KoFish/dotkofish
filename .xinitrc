#!/bin/sh

xrdb -merge ~/.Xresources
LOCAL_XRDB=~/.Xresources.`hostname`
if [ -f $LOCAL_XRDB ]; then
    xrdb -merge $LOCAL_XRDB
fi

if [ -f $HOME/.Xmodmap ]; then
  setxkbmap -option terminate:ctrl_alt_bksp
  /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ "xdwm" = "x"$1 ]; then
    exec ck-launch-session ~/.dwm/start
elif [ "xsecondary" = "x"$1 ]; then
    exec ck-launch-session ̈́/usr/bin/dwm
elif [ "xtv" = "x"$1 ]; then
    exec ck-launch-session ~/.dwm/start-tv
fi
exec ck-launch-session $1 

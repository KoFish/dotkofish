#!/bin/sh

xrdb -merge ~/.Xresources

if [ -f $HOME/.Xmodmap ]; then
  setxkbmap -option terminate:ctrl_alt_bksp
  /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ "xdwm" = "x"$1 ]; then
    exec ck-launch-session ~/.dwm/start
elif [ "xtv" = "x"$1 ]; then
    exec ck-launch-session ~/.dwm/start-tv
fi
exec ck-launch-session $1 

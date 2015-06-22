#!/bin/sh

xrdb -merge $HOME/.Xresources

export QT_STYLE_OVERRIDE=gtk
export TERMINAL=$HOME/.bin/term.sh

( sleep 5s && $HOME/.bin/setup_desktop.sh & ) &

xrandr --output DVI-D-2 --auto

exec i3

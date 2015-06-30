#!/bin/sh

xrdb -merge $HOME/.Xresources

export QT_STYLE_OVERRIDE=gtk
export TERMINAL=$HOME/.bin/term.sh
export EDITOR=nvim

( sleep 2s && $HOME/.bin/setup_desktop.sh & ) &

xrandr --output DVI-D-2 --auto

echo "Starting at $(date)" >> ~/.i3/logfile
exec /usr/bin/i3 -V -d all >> ~/.i3/logfile

#!/bin/sh

if [ `hostname` = 'kinkyfish' ]; then
  conky -c ~/.dwm/conky_netbook | dzen2 -e '' -fg '#cccccc' -bg '#2d2d2d' -fn \
    '-*-fixed-medium-r-*-*-10-*-*-*-*-*-iso8859-1' -ta r
else
  #conky -c ~/.dwm/conkyrc | dzen2 -e '' -fg '#cccccc' -bg '#2d2d2d' -fn \
    #'-*-fixed-medium-r-*-*-12-*-*-*-*-*-iso8859-1' -ta r -w '1280' -x '1280'
  conky -c ~/.dwm/conkyrc | dzen2 -e '' -fg '#cccccc' -bg '#2d2d2d' -fn \
    '-*-Deja Vu Sans Mono-medium-r-*-*-12-*-*-*-*-*-*-*' -ta r -w '1280' -x '1280'
fi

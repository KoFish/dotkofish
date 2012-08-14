#!/bin/sh

win="$(lsw | grep -v ^\<unknown\> | dmenu | awk '{print $NF}')"
test $win && xprop -root -f _DWM_FOCUS 32c -set _DWM_FOCUS $win

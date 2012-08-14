#!/bin/sh

ssh chat@cui.kofish.org "tail -f ~/.irssi_pipe" | dzen2 -l '8' -tw '300' \
  -x '480' -w '600' -fg '#888888' -bg '#333333' \
  -fn '-*-fixed-medium-r-*-*-12-*-*-*-*-*-iso8859-1' 

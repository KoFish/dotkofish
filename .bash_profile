#
# ~/.bash_profile
#

if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
  while true; do
    read -p 'Do you want to start X? (y/n): '
    case $REPLY in
      [Yy]) exec xinit dwm -- /usr/bin/X -nolisten tcp vt7 ;;
      [Nn]) break ;;
      *) printf '%s\n' 'Please answer y or n.' ;;
    esac
  done
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

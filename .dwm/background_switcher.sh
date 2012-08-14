#/bin/bash

while true; do
    SLEEPER="/tmp/bg-sleep-timer${DISPLAY:1}"
    [ -e $SLEEPER ] && rm $SLEEPER
    NOW=`date +'%H'`
    if [ $NOW -gt 22 ] || [ $NOW -lt 6 ]; then
        WP_DIR=~/.wallpapers/dark/
    else
        WP_DIR=~/.wallpapers/light/
    fi
    IMG=`find $WP_DIR "*.{gif,png,jpg,GIF,PNG,JPG}" 2>/dev/null | shuf | head -n1`
    SIZ=`convert "${IMG}" -print "%w %h" /dev/null`
    W=${SIZ% *}
    H=${SIZ#* }
    if [ $W -gt `echo "${H}*12/10" | bc` ]; then
        feh --no-xinerama --bg-fill ${IMG}
    else
        if [ $H -gt $W ]; then
            feh --bg-max ${IMG}
        else
            feh --bg-fill ${IMG}
        fi
    fi
    ( sleep 20m &
    sleep_pid=$!
    echo $sleep_pid > $SLEEPER
    wait $sleep_pid )
done


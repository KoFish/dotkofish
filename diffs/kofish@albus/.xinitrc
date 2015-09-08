--- /home/kofish/Sources/userconfsh/repos/kofish/home/.xinitrc	2015-09-08 16:05:13.744035847 +0200
+++ /home/kofish/.xinitrc	2015-08-17 16:46:13.319887160 +0200
@@ -8,7 +8,9 @@
 
 ( sleep 2s && $HOME/.bin/setup_desktop.sh & ) &
 
-xrandr --output DVI-D-2 --auto
+xrandr --output eDP1 --auto
+xrandr --output DP1 --auto
+xrandr --output DP1 --rotate left --right-of eDP1
 
 echo "Starting at $(date)" >> ~/.i3/logfile
 exec /usr/bin/i3 -V -d all >> ~/.i3/logfile

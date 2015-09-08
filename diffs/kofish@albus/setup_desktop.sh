--- /home/kofish/Sources/userconfsh/repos/kofish/scripts/setup_desktop.sh	2015-09-08 16:05:13.744035847 +0200
+++ /home/kofish/.bin/setup_desktop.sh	2015-06-30 15:41:31.553618558 +0200
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-keepass &
-clipit &
-$HOME/.bin/background_switcher.sh &
-
+xsetroot -solid "#333333"
+xautolock -time 5 -locker "i3lock -e -c 333333" &
+feh --bg-fill --no-xinerama $HOME/wallpaper.jpg

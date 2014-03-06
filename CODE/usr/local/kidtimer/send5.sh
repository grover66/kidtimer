#!/bin/bash
K=$1
basedir="/usr/local/kidtimer"
configdir="/etc/kidtimer"
if [ -e $basedir/locale/$LANG ]; then
	/bin/su $K -c 'DISPLAY=:0 /usr/bin/notify-send -i /usr/share/pixmaps/gnome-set-time.png "ALERT" "`sed -n '6p' /usr/local/kidtimer/locale/$LANG`"'
else
	/bin/su $K -c 'DISPLAY=:0 /usr/bin/notify-send -i /usr/share/pixmaps/gnome-set-time.png "ALERT" "Your computer time will end in 5 minutes."'
fi
echo "ALERT: $K, `sed -n '6p' /usr/local/kidtimer/locale/$LANG`" | /usr/bin/wall -n

#!/bin/sh

# This script makes kidtimer update account status when the machine is woken up.
# For a laptop, these are the closest parallels to turning on a desktop.
# /usr/lib/pm-utils/sleep.d --- so kidtimer will run when my computer is
#   awoken from sleep

case $1 in
    resume|thaw)
        /usr/local/bin/kidtimer hourly
        ;;
esac

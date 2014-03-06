#!/bin/bash
Name=$1
/usr/bin/pkill -KILL -u $Name
rm -rf /tmp/kidtimer.shutdown.$Name

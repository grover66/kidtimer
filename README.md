# Kidtimer

# Purpose: 
Set limits on computer time per day

# Operation: 
This shell script runs from cron every minute to decrement the number of minutes your child has been using their computer.  If your child has spent more time on their computer then you have allowed, it will queue up 5 warning messages and a hibernate via the 'at' command.  As 'at' executes these commands, it will show a message on the users window and count down the number of minutes before issuing the hibernate. The child can watch via... kidtimer gettime user or watch the /tmp directory.  I find my 10 year old likes to issue commands from the shell as it seems more "hacker like"... I have provided her with a print out and told her that she could defeat it if she looks hard enough. I will fix these as she discovers them... currently it is fairly easy to defeat which makes it more intersting for her from my perspective as a teaching aid.

Modified to do the following.

1) changed so that we issue a pm-hibernate instead of killing the session. The kill proved to destroy her work which seemed unfair.

2) check every minute instead of hourly, daily, minute, etc to make this more robust.  Change the logic to handle this in one place.  Thus all we need is a single crontab entry that does a kidtimer check. Found there were a few places that allowed her to get more time once we moved to the hibernate model from kill.

3) added the ability to provide a file that can provide more time.  My daughter comes to me and I issue her a key that she then uses by issuing a: touch /tmp/key to get more time... When kidtimer see's that file, it will issue a 'reset' and provide her another session.

The key can be created with command
```bash
% generate_key.sh 
```

Here is how we use it. We check every minute given we use suspend.
```bash
% cat /etc/cron.d/kidtimer
* * * * *                root        /usr/local/bin/kidtimer check
```

I liked to view when she brought the machine up or down and tracked that via this method:

```bash
% cat /etc/pm/sleep.d/0_jad

#!/bin/bash

case "$1" in
suspend|hibernate)
    /usr/bin/logger -n swlogger.example.com -p auth.info NETWORK Samy off
    ;;
resume|thaw)
    /usr/bin/logger -n swlogger.example.com -p auth.info NETWORK Samy on
    ;;
esac
```

Where swlogger.example.com was a syslog server that is running swatch. You can substitute logger with mail, texing, etc. 

Please notify me should you find bugs as the original author is not responsible for my errors. I have left or not fixed some of the code as it currently isn't used by us .. ie. kidtimer check is all we do.

# NOTE:
I have not rebuilt the DEB package version of kidtimer. The version listed in the top directory here is the latest working version. You can copy it into place. No other options are required via cron with this version... just run 'kidtimer check' which should run every minute as shown above.


# Original text below from grover66.

I have been looking for a solution to this for a long time. I have two kids and wish to restrict their time on the computers. Since nothing else seems to work out there, I decided to write my own. I call it kidtimer. Very original, I know. :)

Kidtimer should work on any recent version of Ubuntu, both 32 & 64 bit. Should also work on Debian too. It uses standard Linux utilities and notify-send (for user notification).

### NOTE ###
* The "at" utility is required for kidtimer to work properly.
* Kidtimer will now check when run manually, letting you know what needs to be installed.

So this is how to install it and use it;

1. Download the latest kidtimer deb file;
https://github.com/grover66/kidtimer/raw/master/DEBS/kidtimer_latest.deb

2. Install it using Software Center or use the following lines;
<pre>
sudo dpkg -i kidtimer*.deb
sudo apt-get -f install
</pre>

3. Run it:
<pre>
sudo kidtimer
</pre>

4. Setup a existing user account.

5. Done.

For help:
<pre>
sudo kidtimer help
</pre>

Add time to a user's account (for that day only):
<pre>
sudo kidtimer addtime user minutes
</pre>

To check user's time:
<pre>
sudo kidtimer gettime user
</pre>

To update kidtimer to the latest version:
<pre>
sudo kidtimer update
</pre>


Features:

Allow your kid specific hours of the day to access the computer, both weekday and weekend.

Set maximum amount of time, both weekday and weekend.

Key files:
<pre>
/etc/kidtimer/kid.list
/etc/cron.d/kidtimer
/usr/local/kidtimer/locale/de_DE.UTF-8 #German
/usr/local/kidtimer/locale/en_US.UTF-8 #English
/usr/local/kidtimer/locale/es_ES.UTF-8 #Spanish
/usr/local/kidtimer/locale/fr_FR.UTF-8 #French
/usr/local/kidtimer/locale/fr_BE.UTF-8 #French
/usr/local/kidtimer/locale/fr_CA.UTF-8 #French
/usr/local/kidtimer/locale/fr_CH.UTF-8 #French
/usr/local/kidtimer/locale/it_IT.UTF-8 #Italian
/usr/local/kidtimer/schedule/<user>
/usr/local/kidtimer/time/<user>.ttl
/usr/local/bin/kidtimer
</pre>

Cronjobs:

Check every minute to see if user is logged in. If so, increment total time. If hit max time, disable account and start logoff sequence (5 mins total).

Check hourly to see if user is allowed to login. If so, enable account.

At midnight, reset time.

The application uses notify-send to alert user time is running out. When time runs out, all user processes are terminated, so please prepare user.

Enjoy!

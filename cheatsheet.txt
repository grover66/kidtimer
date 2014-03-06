Kidtimer Command Line Cheat Sheet
-----------------------------------

Remote control of kidtimer.

* To run kidtimer commands remotely, you will need to install an ssh server and set a root password on your child's computer;
<pre>
sudo apt-get install openssh-server
sudo passwd root
</pre>

* Remotely add, check & reset time on your kids computer;
<pre>
ssh root@kidscomputerip "kidtimer addtime <user> <minutes>"
ssh root@kidscomputerip "kidtimer gettime <user>"
ssh root@kidscomputerip "kidtimer reset <user>"
</pre>

* Adding or resetting time will stop the logoff process, allowing your child to continue to work, study or play.

* Run kidtimer TUI remotely;
<pre>
ssh root@kidscomputerip "kidtimer"
</pre>

* Full command list;
<pre>
addtime <user> <minutes> ... Increases allowed time for the day.
gettime <user> ... Prints remaining time for the day.
reset <user> ... Reset time for the day.
logout <user> ... Starts logout sequence for user.
hourly ... Enables/disables user access based on the schedule.
daily ... Resets time for the new day.
info ... Gather local configurations to troubleshoot issues.
help ... This list.
</pre>


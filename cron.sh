#!/bin/bash

# the color code taken and modified from : https://deb.nodesource.com/setup_14.x
if test -t 1; then # if terminal
    ncolors=$(which tput > /dev/null && tput colors) # supports color
    if test -n "$ncolors" && test $ncolors -ge 8; then
        bold="$(tput bold)"
        normal="$(tput sgr0)"
        cyan="$(tput setaf 6)"
    fi
fi

echo -e "\n${bold}Starting cronode with Node.js version 14 ... ${normal}\n";
echo "Current schedule for the task is : ${cyan} $SCHEDULE ${normal}";
echo -e "Current task is : ${cyan} $TASK ${normal}\n\n";

echo -e "When the task is run, the task output will be below : \n\n";

mkdir /var/log/cron;
touch /var/log/cron/task.log;

touch /etc/cron.d/mytask;
chmod 644 /etc/cron.d/mytask;
echo -e "SHELL=/bin/bash\nPATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n\n" > /etc/cron.d/mytask; 
echo -e "$SCHEDULE root cd /app && echo \"$(date +'%Y-%m-%d %H:%M:%S') - Running the task : $TASK\" >> /var/log/cron/task.log && $TASK >> /var/log/cron/task.log 2>&1 \n" >> /etc/cron.d/mytask;

cron;
tail -f /var/log/cron/task.log;
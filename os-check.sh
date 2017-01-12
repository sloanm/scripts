#!/bin/bash
declare -a host
host=( `cat 004hosts` )
#host=( `cat rhel-sorted` )
#host=( `cat win-sorted` )

for i in "${host[@]}"
do
os2=`salt  $i grains.get os`
os3=`echo $os2 | awk '{print $2}'`

if [ "$os3" == "RedHat" ] ; then
        echo $i  |  tee os-release-output
        echo $os1 |  tee os-release-output
                salt -L $i cmd.run "cat /etc/rsyslog.conf | grep '*.info'" > rhel-1
                sleep 3
                ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rhel-1`

        if [ "$ip" != "10.153.128.36" ] ; then
                echo "$i does not have the correct the current ip is: $ip"
        fi
        cat rhel-1   |  tee os-release-output
fi

if [ "$os3"  == "Windows" ]; then
        echo $i   |  tee os-release-output
        echo $os1  |  tee os-release-output
                salt -L $i cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2008
                sleep 5
                ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" file.txt`
        if [ "$ip" == "10.153.130.82" ] ; then
                salt $i cmd.script salt://intu/pi-enttools/Evtmon/restart-evtmon.bat |  tee os-release-output
        else
                echo "$i IP is not the real ip, the current ip is "$ip" "
        fi
        cat 2008    |  tee os-release-output
fi
done

: <<'END'

END

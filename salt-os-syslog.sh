#!/bin/bash

#host=$1

declare -a host
host=( `cat 10-hosts-sorted` )
#host=( `cat rhel-hosts` )

for i in "${host[@]}"
do
echo $host
os1=`salt  $i grains.get osrelease`
os2=`salt  $i grains.get os`
os3=`echo $os2 | awk '{print $2}'`


#os1=`echo 2008ServerR2' | tr -d \' | awk '{print $1}'`

#echo "$os1"

if [ "$os1"  == "2008ServerR2" ]
then
	echo $t   |  tee os-release-output
	echo $os  |  tee os-release-output
	salt -L $i cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2008
	sleep 5
	ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" file.txt`
 	if [ "$ip" == "10.153.130.82" ]
	then
	salt $i cmd.script salt://intu/pi-enttools/Evtmon/restart-evtmon.bat |  tee os-release-output
	else
		echo "IP is not the real ip "$ip" "
	fi
	cat 2008    |  tee os-release-output
fi

if [ "$os3" == "RedHat" ] ; then
	echo $i  |  tee os-release-output
	echo $os |  tee os-release-output
	salt -L $i cmd.run "cat /etc/rsyslog.conf | grep '*.info'" > rhel-1
	sleep 3
	ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rhel-1`

	if [ "$ip" != "10.153.128.36" ]
	then
	echo "$i does not have the correct ip"
	fi
	cat rhel-1   |  tee os-release-output
fi

if [ "$os1" == "2012ServerR2" ] ; then
	echo $i    |  tee os-release-output
	echo $os   |  tee os-release-output
	salt -L $i cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2012
	sleep 10
	ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" file.txt`
        if [ "$ip" == "10.153.130.82" ]
        then
        salt $i cmd.script salt://intu/pi-enttools/Evtmon/restart-evtmon.bat |  tee os-release-output
        #salt $i cmd.script salt://intu/pi-enttools/Evtmon/restart-evtmon.ps1 shell='powershell'
        else
                echo "IP is not the real ip "$ip" "
        fi
	cat 2012  |  tee os-release-output
fi
done

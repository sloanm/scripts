#!/bin/bash

host=$1

echo $host

os=`salt $host grains.get osrelease`

os1=`echo 2008ServerR2' | tr -d \' | awk '{print $1}'`

echo "$os1"

if [ "$os1"  == "2008ServerR2" ]
then
	salt -L $host cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2008
fi
sleep 9
cat 2008

if [ "$os1" == "6.8" ] ; then
	salt -L $host cmd.run "cat /etc/rsyslog.conf | grep '*.info'"
fi

if [ "$os" == "2012ServerR2" ] ; then
	salt -L $host cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2012
	#salt -L $host cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' | tee 2012
fi

cat 2012

#!/bin/bash

#readarray array < /home/smiller19-admin/004-newlist
readarray array < /home/smiller19-admin/3hosts-delete

for i in "${array[@]}"
do

echo $i
os=$(salt -L $i grains.get os |awk 'FNR==2{print $0}' | sed -e 's/^[ \t]*//' 2>&1 | tee output )
echo $os
echo $i >> output1
echo $os >> output1

#This string is a windows version check

if [ "$os" == "Windows" ]
then
	echo ' OS is a match for ' $os
	#echo 'host is ' $host
	salt -L $host  cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > windows

else
	echo 'os is a match for ' $os
	#echo 'host is ' $host
	salt -L $host cmd.run "cat /etc/rsyslog.conf|grep *.info"
fi

done
sleep 8
cat windows

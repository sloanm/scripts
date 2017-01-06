#!/bin/bash
declare -a host
host=( `cat xaa` )

echo $host > /tmp/host

ping -c 2 $host  > /tmp/reply
cat /tmp/reply |awk '{print $6}' > /tmp/reply1
reply1=`head -2 /tmp/reply1 | tail -1`
echo $reply1

if [ "$reply1" == "icmp_seq=1" ]
         then
        echo "icmp reply is good"
        else
        new_host=`sed 's/.corp.intuit.net/.ie.intuit.net/g' /tmp/host`
        ping -c 1 $new_host
        echo "$new_host is ie.intuit.net not corp"
fi

for i in "${host[@]}"
do
os2=`salt  $i grains.get os`
echo $os2
os3=`echo $os2 | awk '{print $2}'`
echo $os3

check=`salt $i grains.get os`
        echo $check

if [ "$check" == "No minions matched the target. No command was sent, no jid was assigned." ]; then
        echo "$i host needs to have a ticket created" |tee ticket-creation-list
        echo "$i ticket needed "
        echo $1 >> ticket-creation-list
        echo "ERROR: minion likley not working"
fi

if [ "$os3" == "RedHat" ]; then
        echo $i  |  tee os-release-output
        echo $os1 |  tee os-release-output
                salt -L $i cmd.run "cat /etc/rsyslog.conf | grep '*.info'" > rhel-1
                sleep 2
                ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rhel-1`

        if [ "$ip" != "10.153.128.36" ] ; then
                echo "$i does not have the correct the current ip is: $ip"
                echo "QDC C RHEL/OEL upgrade to VIP IP"
                salt -L $i cmd.script salt://intu/pi-enttools/Rsyslog/RemediateRsyslogClient.sh qdcC-vip
        fi
        cat rhel-1   |  tee os-release-output
fi

if [ "$os3"  == "Windows" ]; then
        echo $i   |  tee os-release-output
        echo $os1  |  tee os-release-output
                salt -L $i cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini' > 2008
                sleep 2
                ip=`grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" file.txt`
        if [ "$ip" == "10.153.130.82" ] ; then
                salt $i cmd.script salt://intu/pi-enttools/Evtmon/restart-evtmon.bat |  tee os-release-output
                echo "restarting evtmon via script in repo"
        else
                echo "$i IP is not the real ip, the current ip is "$ip" "
                echo "Evtmon install for qdcC "
                salt $host cmd.script salt://intu/pi-enttools/Evtmon/InstallEvtmon.ps1 args=qdcC-windows shell='powershell'
        fi
        cat 2008    |  tee os-release-output
fi
done

: <<'END'

bla bla
blurfl
END

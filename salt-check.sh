#!/bin/bash

# This script required the selection of the case usage firt
#  [smiller19-admin@qcysaltmom01 ~]$ ./check-host.sh 1
#  Enter the hostname to check :   pe2efdaap301.corp.intuit.net

#read -p "Enter the hostname to check :   " host

if [ $# -eq 0  ]; then
    echo "No arguments provided"
    echo "Enter '1' for hostname check"
    echo "Enter '1a' for hostname check"
    echo "Enter '2' for uname check"
    echo "Enter '3' for grep *.info"
    echo "Enter '4' for upgrade of RHEL / OEL to VIP IP"
    echo "Enter '5' for grep of evtmon\evtmon.ini"
    echo "Enter '6' for config upgrade config file evtmon\evtmon.ini"
    echo "Enter '7' for stop of evtmon"
    echo "Enter '8' for start of evtmon"
    echo "Enter '9' install/upgrade of evtmon via powershell"
    echo "Enter '10' for rsyslogd stop "
    echo "Enter '11' for rsyslogd start"
    exit 1
fi

#read  "Enter the hostname to check :   " host
# -p means no prompt
read -p "Enter the hostname to check :   " host

ping -c 2 $host

case "$1" in
1 ) echo "salt hostname check"
salt -L $host cmd.run hostname
;;
1a ) echo "salt osrelease check"
salt -L $host grains.get osrelease
;;
2 ) echo "salt uname check"
salt -L $host cmd.run "uname -a"
;;
3 ) echo " salt grep *.info "
salt -L $host cmd.run "cat /etc/rsyslog.conf | grep '*.info'"
;;
4 ) echo "QDC C RHEL/OEL upgrade to VIP IP"
salt -L $host cmd.script salt://intu/pi-enttools/Rsyslog/RemediateRsyslogClient.sh qdcC-vip
;;
5 ) echo "Windows evtmon.ini check"
salt -L $host cmd.run 'type C:\evtmon\evtmon.ini'
;;
6 ) echo "Windows evtmon.ini replace"
salt $host cp.get_file   salt://intu/pi-enttools/evtmon/evtmon.ini "c:\evtmon\evtmon.ini"
;;
7 ) echo "stop evtmon  "
salt $host cmd.run 'sc stop evtmon'
;;
8 ) echo "start evtmon  "
salt $host cmd.run 'sc start evtmon'
;;
9 ) echo "Evtmon install for qdcC "
salt $host cmd.script salt://intu/pi-enttools/Evtmon/InstallEvtmon.ps1 args=qdcC-windows shell='powershell'
;;
10 ) echo "Rsyslogd stop"
salt $host cmd.run "salt-call service.stop rsyslog"
;;
11 ) echo "Rsyslogd start"
salt $host cmd.run "salt-call service.start rsyslog"
;;
esac

#sloan miller Tools Team.  This script will check the os and give the option to upgrade or re-install
#Evtmon or Rsyslog client after checking the IP in the current evtmon.ini or rsyslog.conf file.

#Sample windows host
#  pppdzzzos3ac.corp.intuit.net
# This script is on the salt master and is called initial_query.sh
# The new direction for the new script is to read in an array from a file that contains hostnames
# mapfile will read a file and make in into an array. Here myArray is made up of the file file.txt
#  mapfile -t myArray < file.txt


echo " "
echo " This script will display which IP the host is currently sending log traffic"
read -p " Enter the hostnames:  " host

echo ' The hostname you have entered is ' $host
echo " "


os=$(salt -L $host grains.get os |awk 'FNR==2{print $0}' | sed -e 's/^[ \t]*//')
echo $os

systeminfo | find /I "OS Name"
#if [ $os -eq Windows ]
if [ "$os" == "Windows" ]
then
	echo ' OS is a match for ' $os
	#echo 'host is ' $host
	salt -L $host  cmd.run 'findstr syslog_host c:\evtmon\evtmon.ini'

else
	echo 'os is a match for ' $os
	#echo 'host is ' $host
	salt -L $host cmd.run "cat /etc/rsyslog.conf|grep *.info"
fi
echo " "
echo " "
echo " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= "
echo " Step two, upgrade/reinstall evtmon or syslog package: "
echo " Currently the script is fixed to set the IP to qdcC"
echo " "
echo " Enter '1' to install the evtmon package with qdcC real ip. "
echo -n " Enter '2' to install rsyslog rpm iwith qdcC VIP IP : "
read yno
case $yno in

1 ) echo "installing evtmon "
#salt $host cp.get_file salt://intu/pi-enttools/Evtmon/InstallEvtmon.ps1 qdcC-windows args=qdcC-windows shell='powershell' --async
echo "Evtmon install option"
;;


2 ) echo "Installing Rsyslog with qdcC VIP IP"
salt -L $host cmd.script salt://intu/pi-enttools/Rsyslog/FixedRemediateRsyslogClient.sh qdcC-vip
echo "Rsyslog install option"
;;
esac

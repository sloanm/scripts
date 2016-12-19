#!/bin/bash
# enter one for grep
#enter 2 for creation of block replace commands

#mapfile -t myArray < hosts

case "$1" in
1 ) echo "Grep /etc/rsyslog.conf command creation"
while IFS= read -r line; do echo "salt $line cmd.script salt://intu/pi-enttools/Rsyslog/grep.info.sh "; done < hosts_good
;;

2 )  echo " Creating block replace command "
while IFS= read -r line; do echo "salt $line cmd.script salt://intu/pi-enttools/Rsyslog/blockreplace.sh "; done < hosts_good > replace-cmds-list 
;;

3 )  echo " Hostname command created"
while IFS= read -r line; do echo "salt $line cmd.run 'hostname'"; done < hosts_good > replace-cmds-list 
;;

4 )  echo " Random Command "
while IFS= read -r line; do echo "salt $line cmd.script salt://intu/pi-enttools/Rsyslog/v4andV5sed.sh"; done < hosts_good > replace-cmds-list 
;;

esac

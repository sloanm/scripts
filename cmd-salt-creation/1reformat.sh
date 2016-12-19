#!/bin/bash
#This script will append and asterisk to the end of each hostname.
#Step two will place single quotes around the hostname.
#Step two in recommended best practice for splunk when using hostname globbing.

echo "filename with hosts:  "
read filename
echo $filename

awk '{print $0"\\"}' $filename > delete
awk '{print $0"*"}'  delete >  hosts_good

#sed 's/$/*/' hosts > asterisk
#for i in `cat asterisk `;do printf "'%s'\n" $i;done > THIS_file
#tr '\012'   ',' < THIS_file

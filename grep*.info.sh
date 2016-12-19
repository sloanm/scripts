#!/bin/bash

#contents =`cat /tmp/rsyslog.info |grep *.info @10.153.130.23` 

if [ "$contents" == "*.info @10.153.130.23" ]
then
 exit 1
else
 exit $?
fi


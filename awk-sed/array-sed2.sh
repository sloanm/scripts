#!/bin/bash


declare -a arr=( pid: retcode: stderr: stdout: )

for i in "${arr[@]}"
do
#	echo "$i"
sed -e 's/$i//g'  

done < win-version-evtmon-issue 

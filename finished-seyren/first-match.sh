#!/bin/bash

while read line
#for i in 
do 

grep -A 1 $line seyren.output |head -6
#grep -A 1 ac15-stor-w1-qcy__mgmt0_dcnet_intuit_net seyren.output |head -6
done < 1final-hosts-only 

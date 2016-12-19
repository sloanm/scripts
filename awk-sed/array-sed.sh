#!/bin/bash


declare -a arr=(collectd.network.QCY-E.nx-os., collectd.network.QCY-E.nx-os.,  collectd.network.QCY-E.f5.,  collectd.network.QCY-E.asa.,collectd.network.QCY-D.nx-os.,   collectd.network.QCY-C.ucv., collectd.network.QCY-C.ucs.,  collectd.network.QCY-C.nx-os.,  collectd.network.QCY-C.nae.,  collectd.network.QCY-C.junos.,  collectd.network.QCY-C.ios.,  collectd.network.QCY-C.f5.,  collectd.network.QCY-C.ecds., collectd.network.QCY-B.nx-os.,  collectd.network.QCY-B.ios.,  collectd.network.QCY-B.f5., collectd.network.QCY-A.sps.,  collectd.network.QCY-A.nx-os., collectd.network.QCY-A.junos., collectd.network.QCY-A.ironport., collectd.network.QCY-A.ios-xe., collectd.network.QCY-A.ios.)  

for i in "${arr[@]}"
do
#	echo "$i"
sed -e 's/$i//g'  

done < cpu-gone 

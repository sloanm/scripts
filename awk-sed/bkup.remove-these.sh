#!/bin/bash


array[0] = collectd.network.QCY-E.nx-os.
array[1] = collectd.network.QCY-E.nx-os.
array[2] = collectd.network.QCY-E.f5.
array[3] = collectd.network.QCY-E.asa.
array[4] = collectd.network.QCY-D.nx-os.
array[5] = collectd.network.QCY-C.ucv.
array[6] = collectd.network.QCY-C.ucs.
array[7] = collectd.network.QCY-C.nx-os.
array[8] = collectd.network.QCY-C.nae.
array[9] = collectd.network.QCY-C.junos.
array[10] = collectd.network.QCY-C.ios.
array[11] = collectd.network.QCY-C.f5.
array[12] = collectd.network.QCY-C.ecds.
array[13] = collectd.network.QCY-B.nx-os.
array[14] = collectd.network.QCY-B.ios.
array[15] = collectd.network.QCY-B.f5.
array[16] = collectd.network.QCY-A.sps.
array[17] = collectd.network.QCY-A.nx-os.
array[18] = collectd.network.QCY-A.junos.
array[19] = collectd.network.QCY-A.ironport.
array[20] = collectd.network.QCY-A.ios-xe.
array[21] = collectd.network.QCY-A.ios.

for element in "${array[@]}"
do
    echo "$element"
done
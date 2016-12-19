#!/bin/bash -x 

awk '/Searching Checks. Based on search criteria:name/,/name: Value : ACE thresholds - Access List Limit/' 


sed1='name: Value :  CPU' 
sed2='name: Value :  Memory' 
sed3='name: Value :  RX_Errors'
sed4='name: Value :  RX_Errors1'
sed5='name: Value :  TX_Errors' 
sed6='name: Value :  TX_Errors1' 
sed7='name: Value : ACE thresholds - Access List Limit' 

datain=seyren-hosts-list

sed -i '' "/$sed1/d" $datain 
sed -i '' "/$sed2/d" $datain 
sed -i '' "/$sed3/d" $datain 
sed -i '' "/$sed4/d" $datain 
sed -i '' "/$sed5/d" $datain 
sed -i '' "/$sed6/d" $datain 
sed -i '' "/$sed7/d" $datain 

: <<'END'
name: Value :  CPU
name: Value :  Memory 
name: Value :  RX_Errors
name: Value :  RX_Errors1
name: Value :  TX_Errors
name: Value :  TX_Errors1
name: Value : ACE thresholds - Access List Limit
END

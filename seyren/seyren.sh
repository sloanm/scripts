#!/bin/bash 

for i in `cat 1final-hosts-only` ;
do
echo $i
/usr/bin/java -jar seyren-api-intuit-wrapper-1.5.1.jar -f api.properties -c SEARCH_CHECK -d "name,(.*)$i(.*)" |grep name
done
sleep 2
done   >  seyren-output 

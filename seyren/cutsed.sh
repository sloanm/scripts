#!/bin/bash 

while read line
do
echo $line
/usr/bin/java -jar seyren-api-intuit-wrapper-1.5.1.jar -f api.properties -c SEARCH_CHECK -d "name,(.*)$line(.*)" |grep name
sleep 2
done < 1final-hosts-only 

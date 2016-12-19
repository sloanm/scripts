#!/bin/bash -x 


declare -a array=(one two three four)  

for element in "${array[@]}"
do
    sed -e 's/'"$element"'/'" "'/g' input > output.remove 
    #sed 's/'"$element"'/'" "')/g' input 
    #sed -i "s/"$element"//g" input 
	#awk "{gsub("$element", "");print}" input
done

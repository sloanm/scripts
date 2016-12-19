#!/bin/bash -x 


#for i in 
while read input ; 
do
    sed -i 's/'"$input"'/'" "'/g' > 1output.remove 
#    echo $i
done <input 
#done <input > 1output.remove 

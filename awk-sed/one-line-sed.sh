#!/bin/bash

one=$1
two=$2
three=$3
four=$4

sed -e 's/"$one"//g' -e 's/"$two"//g' -e 's/"$three"//g' -e 's/"$four"//g' hostnames-graphana.csv > outfile

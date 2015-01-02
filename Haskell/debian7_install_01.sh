#!/bin/bash 

for i in $(cat debian7_package.list)
do
  echo "apt-get install $i" 
  apt-get install $i
done

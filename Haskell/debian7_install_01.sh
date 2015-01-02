#!/bin/bash 

echo "sudo $USER, please type the password of $USER"
sudo
for i in $(cat debian7_package.list)
do
  echo "apt-get install $i" 
  sudo apt-get install $i
done

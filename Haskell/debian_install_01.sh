#!/bin/bash 

echo "sudo $USER, please type the password of $USER"
for i in $(cat debian7_package.list)
do
  cmd="apt-get -y install $i"
  echo "$cmd"
  sudo $cmd
done

#!/bin/bash 

echo "sudo $USER, please type the password of $USER"
sudo
for i in $(cat debian_package.list)
do
  cmd="apt-get -y install $i"
  echo "$cmd"
  sudo $cmd
done

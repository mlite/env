#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <user>"
    echo "  <user> is the user to be added to sudoers"
    exit 1
fi
user=$1
apt-get install sudo
adduser $user sudo
echo "$user  ALL=(ALL:ALL) ALL" >> /etc/sudoers

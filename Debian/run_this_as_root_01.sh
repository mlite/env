#!/bin/bash
user=$USER
su root
apt-get install sudo
adduser $user sudo
echo "$user  ALL=(ALL:ALL) ALL" >> /etc/sudoers

#!/bin/bash
apt-get install sudo
adduser $USER sudo
echo "$USER  ALL=(ALL:ALL) ALL" >> /etc/sudoers

#!/bin/bash
sudo echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jess-backports.list
sudo apt-get update
sudo apt-get install -y certbot -t jessie-backports


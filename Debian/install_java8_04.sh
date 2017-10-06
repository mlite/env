#!/bin/bash
sudo echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
sudo update-alternative --config java

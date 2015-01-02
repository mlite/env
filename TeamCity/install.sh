#!/bin/bash

echo "install openjdk 7"
sudo apt-get -y install openjdk-7-jdk

if [ ! -f TeamCity-9.0.1.tar.gz ]; then
  wget http://download.jetbrains.com/teamcity/TeamCity-9.0.1.tar.gz
fi

gzip -dc TeamCity-9.0.1.tar.gz | tar xvf -
cd TeamCity-9.0.1

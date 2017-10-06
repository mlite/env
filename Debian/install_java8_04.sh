#!/bin/bash
sudo echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -t jessie-backports -y openjdk-8-jre-headless ca-certificates-java

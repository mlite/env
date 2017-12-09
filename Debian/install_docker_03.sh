#!/bin/bash
sudo apt-get update

#add repository for docker-ce
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common -y

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"


#install docker-ce
sudo apt-get update
sudo apt-get install docker-ce -y

#verify it works
sudo docker run hello-world




sudo useradd -G docker $USER

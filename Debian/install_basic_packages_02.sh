#!/bin/bash
echo "export PATH=.:\$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
echo "sudo: type the password of $USER"
sudo apt-get -y install build-essential
sudo apt-get -y install python-dev
sudo apt-get -y install unzip
sudo apt-get -y install cmake m4

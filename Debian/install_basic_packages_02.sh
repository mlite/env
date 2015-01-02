#!/bin/bash
echo "export PATH=.:\$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
echo "sudo: type the password of $USER"
sudo apt-get -y install build-essential

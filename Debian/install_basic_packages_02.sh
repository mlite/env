#!/bin/bash
echo "export PATH=.:\$HOME/local/bin:\$HOME/.cabal/bin:\$HOME/llvm-install/bin:\$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
echo "sudo: type the password of $USER"
sudo apt-get -y install build-essential

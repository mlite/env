#!/bin/bash
cd $HOME
git clone https://github.com/mlite/env
cd $HOME/env/Llvm
sh install.sh

cd $HOME/env/Haskell
sh install.sh

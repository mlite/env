#!/bin/bash 

# download ghc
wget https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-src.tar.bz2

bzip2 -dc ghc-7.8.3-src.tar.bz2 | tar xvf -

cd ghc-7.8.3
mkdir /home/$USER/local
./configure --prefix=/home/$USER/local
make install

cabal update
cabal install cabal-install

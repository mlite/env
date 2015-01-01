#!/bin/bash 

# download ghc
wget https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-src.tar.bz2

bzip2 -dc ghc-7.8.3-src.tar.bz2 | tar xvf -

cd ghc-7.8.3
mkdir /home/$USER/local
./configure --prefix=/home/$USER/local
make install

for i in $(cat debian7_package.list)
do
  echo "apt-get install $i" 
  apt-get install $i
done

cabal update
cabal install happy
cabal install alex
cabal install gtk2hs-buildtools
cabal install leksah
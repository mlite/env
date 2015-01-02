#!/bin/bash 

# download ghc
if [ ! -f ghc-7.8.3-src.tar.bz2 ]; then
  wget https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-src.tar.bz2
fi

rm -rf ghc-7.8.3
bzip2 -dc ghc-7.8.3-src.tar.bz2 | tar xvf -

cabal update
cabal install happy
cabal install alex

export PATH=$HOME/.cabal/bin:$PATH
 
cd ghc-7.8.3
mkdir /home/$USER/local
./configure --prefix=/home/$USER/local
make install


# we need to use ghc-7.8.3 to install cabal-install
export PATH=$HOME/local/bin:$PATH

cabal update
cabal install cabal-install

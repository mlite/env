#!/bin/bash -x

cd $HOME
mkdir $HOME/local

NUMJOBS=`nproc`

# download ghc
if [ ! -f ghc-7.8.3-src.tar.bz2 ]; then
    wget https://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-src.tar.bz2
fi

rm -rf ghc-7.8.3
bzip2 -dc ghc-7.8.3-src.tar.bz2 | tar xvf -

export PATH=$HOME/.cabal/bin:$PATH
 
cd ghc-7.8.3
./configure --prefix=$HOME/local/ghc
make -j ${NUMJOBS}
make install


# we need to use ghc-7.8.3 to install cabal-install
export PATH=$HOME/local/ghc/bin:$PATH

cabal update
cabal install cabal-install

echo "export PATH=$HOME/local/ghc/bin:$HOME/.cabal/bin:$PATH" >> $HOME/.bashrc

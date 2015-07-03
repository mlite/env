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

cd ghc-7.8.3
./configure --prefix=$HOME/local/ghc
make -j ${NUMJOBS}
make install
cd ..


# we need to use ghc-7.8.3 to install cabal-install
export PATH=$HOME/local/ghc/bin:$PATH

wget https://www.haskell.org/cabal/release/cabal-install-1.22.6.0/cabal-install-1.22.6.0.tar.gz
gzip -dc cabal-install-1.22.6.0.tar.gz | tar xvf -
cd cabal-install-1.22.6.0
sh ./bootstrap.sh

echo "export PATH=$HOME/local/ghc/bin:$HOME/.cabal/bin:$PATH" >> $HOME/.bashrc

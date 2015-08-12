#!/bin/bash -x
GHCVER=7.8.4
CABALVER=1.22.6.0

cd $HOME
mkdir $HOME/local

NUMJOBS=`nproc`

# download ghc
if [ ! -f ghc-${GHCVER}-src.tar.bz2 ]; then
    wget https://www.haskell.org/ghc/dist/${GHCVER}/ghc-${GHCVER}-src.tar.bz2
fi

rm -rf ghc-${GHCVER}
bzip2 -dc ghc-${GHCVER}-src.tar.bz2 | tar xvf -

cd ghc-${GHCVER}
./configure --prefix=$HOME/local/ghc
make GhcProfiled=YES 
make install
cd ..


# we need to use this ghc to install cabal-install
export PATH=$HOME/local/ghc/bin:$PATH

wget https://www.haskell.org/cabal/release/cabal-install-${CABALVER}/cabal-install-${CABALVER}.tar.gz
gzip -dc cabal-install-${CABALVER}.tar.gz | tar xvf -
cd cabal-install-${CABALVER}
EXTRA_CONFIGURE_OPTS="--enable-library-profiling --enable-shared" ./bootstrap.sh

echo "export PATH=$HOME/local/ghc/bin:$HOME/.cabal/bin:$PATH" >> $HOME/.bashrc

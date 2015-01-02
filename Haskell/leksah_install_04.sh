#!/bin/bash 

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH

cabal update
cabal install happy
cabal install alex
cabal install gtk2hs-buildtools
cabal install leksah

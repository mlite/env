#!/bin/bash
debian_install_01.sh
ghc_cabal_install_02.sh
debian_remove_03.sh
echo "export PATH=.:\$HOME/local/bin:\$HOME/.cabal/bin:\$PATH" >> $HOME/.bashrc
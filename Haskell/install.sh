#!/bin/bash
SCRIPT_PATH=$(dirname $(readlink -f $0))
sh ${SCRIPT_PATH}/debian_install_01.sh
sh ${SCRIPT_PATH}/ghc_cabal_install_02.sh
source $HOME/.bashrc

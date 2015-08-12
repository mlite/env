#! /bin/bash
SCRIPT_PATH=$(dirname $(readlink -f $0))

INSTALL_DIR=$HOME/local/llvm
CWD=`pwd`
echo $CWD


cd llvm-build
cmake -G"Eclipse CDT4 - Unix Makefiles" -DCC=/usr/bin/gcc -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE -D_ECLIPSE_VERSION=4.4 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DBUILD_SHARED_LIBS=ON ../llvm-3.5.0.src
cd ..

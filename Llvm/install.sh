#!/bin/bash
if [ ! -f llvm-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/llvm-3.5.0.src.tar.xz
fi


rm -rf llvm-3.5.0.src
tar xvfJ llvm-3.5.0.src.tar.xz


rm -rf llvm-build
mkdir llvm-build


cd llvm-build
../llvm-3.5.0.src/configure --prefix=/home/$USER/llvm-install
make
make -C test

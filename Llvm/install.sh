#!/bin/bash
if [ ! -f llvm-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/llvm-3.5.0.src.tar.xz
fi

if [ ! -f test-suite-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/test-suite-3.5.0.src.tar.xz
fi

rm -rf llvm-3.5.0.src
tar xvfJ llvm-3.5.0.src.tar.xz
cd llvm-3.5.0.src/projects 
tar xvfJ ../../test-suite-3.5.0.src.tar.xz


cd ../../

rm -rf llvm-build
mkdir llvm-build


cd llvm-build
../llvm-3.5.0.src/configure --prefix=/home/$USER/llvm-install
make

#!/bin/bash
mkdir $HOME/local

if [ ! -f llvm-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/4.5.0/llvm-3.5.0.src.tar.xz
fi

if [ ! -f cfe-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/cfe-3.5.0.src.tar.xz
fi

if [ ! -f compiler-rt-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/compiler-rt-3.5.0.src.tar.xz
fi

if [ ! -f test-suite-3.5.0.src.tar.xz ]; then
  wget http://llvm.org/releases/3.5.0/test-suite-3.5.0.src.tar.xz
fi


echo "unzip llvm ..."
rm -rf llvm-3.5.0.src
tar xvfJ llvm-3.5.0.src.tar.xz -C ./

echo "unzip clang ..."
tar xvfJ cfe-3.5.0.src.tar.xz -C ./llvm-3.5.0.src/tools
mv llvm-3.5.0.src/tools/cfe-3.5.0.src ./llvm-3.5.0.src/tools/clang
cp llvm_patch/ExternalModulePass.cpp ./llvm-3.5.0.src/tools/clang/lib/CodeGen
cd ./llvm-3.5.0.src
patch -p1 -i ../llvm_patch/externalModulePass.patch 
cd ..

echo "unzip test-suite ..."
tar xvfJ test-suite-3.5.0.src.tar.xz -C ./llvm-3.5.0.src/projects

rm -rf ./llvm-build
mkdir ./llvm-build


NJOBS=`nproc`

cd ./llvm-build
../llvm-3.5.0.src/configure --prefix=$HOME/local/llvm
make -j $NJOBS
make check-all



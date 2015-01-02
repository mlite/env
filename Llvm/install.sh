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

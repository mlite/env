#!/bin/bash

if [ ! -f dragonegg-3.5.0.src.tar.xz ]; then
   wget http://llvm.org/releases/3.5.0/dragonegg-3.5.0.src.tar.xz
fi

sudo apt-get install gcc-4.7-plugin-dev

rm -rf dragonegg-3.5.0.src
tar xf dragonegg-3.5.0.src.tar.xz
cd dragonegg-3.5.0.src
make

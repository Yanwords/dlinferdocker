#!/bin/sh 
# apt install tools and libraries required o build SentencePiece.
# sudo apt install cmake build-essential pkg-config libgoogle-perftools-dev
# build and install sentencepiece on Ubuntu 20.04.
git clone https://github.com/google/sentencepiece.git 
cd sentencepiece
mkdir build
cd build
cmake ..
make -j $(nproc)
make install
ldconfig -v


#!/bin/bash
# 
# Install latest cmake

cd working

wget https://cmake.org/files/v3.30/cmake-3.30.5.tar.gz
tar -xzvf cmake-3.30.5.tar.gz
cd cmake-3.30.5
./bootstrap
make -j$(nproc)
sudo make install

cd ../..



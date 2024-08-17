#!/bin/bash
# 
# Install ZeroMQ

cd working
[ "$?" != "0" ] && exit 1

wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz
tar xzf libsodium-1.0.18.tar.gz
cd libsodium-1.0.18
./configure
make 
sudo make install
sudo ldconfig
cd ..

# 4.3.5 doesn't seem to have curve? Just use the earlier one for now.
wget https://github.com/zeromq/zeromq4-1/releases/download/v4.1.5/zeromq-4.1.5.tar.gz
tar xzf zeromq-4.1.5.tar.gz
cd zeromq-4.1.5
./configure
make
sudo make install
sudo ldconfig
cd ..

git clone https://github.com/zeromq/libzmq.git
cd libzmq
mkdir build
cd build
cmake ..
make -j4
make test
sudo make install
cd ../..

git clone https://github.com/zeromq/cppzmq
cd cppzmq
mkdir build
cd build
cmake ..
make -j4
sudo make install
cd ../..

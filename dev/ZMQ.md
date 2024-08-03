
```
wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.19-stable.tar.gz  
tar xzf libsodium-1.0.19-stable.tar.gz
cd libsodium-stable
./configure
make 
sudo make install
sudo ldconfig
cd ..

wget https://github.com/zeromq/libzmq/releases/download/v4.3.5/zeromq-4.3.5.tar.gz
tar xzf zeromq-4.3.5.tar.gz
cd zeromq-4.3.5
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
cd ..
```

# Installing Boost 1.85.0 from source

This has been tested in Ubuntu 24.04
- AWS T4G
- Raspberry PI 4 and 5

```
wget https://github.com/boostorg/boost/releases/download/boost-1.85.0/boost-1.85.0-b2-nodocs.tar.gz
tar xzf boost-1.85.0-b2-nodocs.tar.gz 
cd boost-1.85.0
./bootstrap.sh --prefix=/usr --with-python=python3
./b2 stage threading=multi link=shared boost.stacktrace.from_exception=off

# as root user
sudo -s
./b2 install threading=multi link=shared
exit
```

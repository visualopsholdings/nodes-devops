
# Installing ZeroMQ tools from source

This has been tested in Ubuntu 24.04
- AWS T4G, T2
- Raspberry PI 4 and 5
- Macintosh

Copy over and run "zmq.sh".

If you are actually ON the machine where you want to run the script, check out
the project:

```
cd ~
git clone https://github.com/visualopsholdings/nodes-devops
nodes-devops/dev/zmq.sh
```

Note on a Macintosh some of these scripts might get a quarantine bit set. So if you see
"zsh: operation not permitted" you might run this:

```
xattr -d com.apple.quarantine nodes-devops/dev/zmq.sh
```

# Solving "curve not available"

This is usually due to a later version of ZMQ (4.3.5) on Ubuntu. The version you need
to be running is 4.1.5.

If you:

```
ls -al /usr/local/lib/libzmq
```

And you see anything other than:

```
libzmq.so.5 -> libzmq.so.5.0.1
```

Then you have the wrong version.

Simply:

```
cd /usr/local/lib
sudo rm libzmq.so.5
sudo ln -s libzmq.so.5.0.1 libzmq.so.5
```

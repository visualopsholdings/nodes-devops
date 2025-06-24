
# Installing Boost 1.85.0 from source

## Ubuntu 24.04 

This has been tested:
- AWS T4G, T2
- Raspberry PI 4 and 5
- WSL
- Mac OS

On a VM:

Copy over and run "boost.sh" with scp/ssh.

If you are actually ON the machine where you want to run the script, check out
the project:

```
cd ~
git clone https://github.com/visualopsholdings/nodes-devops
nodes-devops/dev/boost.sh
```

Then:

```
# as root user
sudo -s
./b2 install
^C
```

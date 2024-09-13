
# Installing the C++ Mongi DB driver

This has been tested in Ubuntu 24.04
- AWS T4G, T2
- Raspberry PI 4 and 5
- Macintosh

Copy over and run "mongo.sh".

If you are actually ON the machine where you want to run the script, check out
the project:

```
cd ~
git clone https://github.com/visualopsholdings/nodes-devops
nodes-devops/dev/mongo.sh
```

On a linux you might need:

```
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
```

Note on a Macintosh some of these scripts might get a quarantine bit set. So if you see
"zsh: operation not permitted" you might run this:

```
xattr -d com.apple.quarantine nodes-devops/dev/mongo.sh
```
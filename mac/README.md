# Mac OS

You can use these steps to setup a runtime (or development) system for Nodes on the Macintosh OS.

In fact I use a Macintosh to do the main development of the nodes project.

## Prerequisites

For simplicity, create a "Dev" folder on your mac in your home folder.

From the command line you could do this with

```
mkdir ~/Dev
```

## Download THIS project and navigate to the macintosh scripts.

```
git clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops/mac
```

## Download and install the binary builds

You can find the latest builds in our github.

```
brew install wget
cd ~/Dev
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v.0.0.2/mac-sonoma.tgz
tar xzf mac-sonoma.tgz
mv mac-sonoma/nodes-lib .
mv mac-sonoma/nodes .
mv mac-sonoma/nodes-web .
mv mac-sonoma/nodes-irc .
rm -rf mac-sonoma*
```

That's it :-)

It's possible that when you run one of the binaries you find that it's missing the exact libraries
for your slightly different Ubuntu version. If so, you can replace this step by downloading and building from source:

- https://github.com/visualopsholdings/nodes
- https://github.com/visualopsholdings/nodes-irc
- https://github.com/visualopsholdings/nodes-web

Note that it's best to at least start out with the binaries since you will get it all going much
faster :-)

### MongoDB

```
brew install mongodb-community
```

Get Compass from here

https://www.mongodb.com/try/download/compass


#### Populate MongoDB

Run "MongoDB Compass".

You can connect to the local database by creatig a new connection and taking the default.

Click "Open MongoDB shell" for direct access to the mongo shell. 

Create a new local database called "nodes" (use users as the collection).

Paste this in:

```
use nodes
db.createUser(
    {
      user: "nodes",
      pwd: "nodes",
      roles: [
          { role: "readWrite", db: "nodes" }
      ]
    }
)
```

Extract the initial DB contents inside WSL (so in the terminal in Visual Studio):

```
cd nodes/mongodb
tar xzf initial.tgz
mongorestore --username=nodes --password=nodes --db=nodes --drop dump/fiveEstellas --authenticationDatabase=nodes
```

### NgINX

Now that everything starts up, you want to be able to access nodes from the browser and there
are a few steps still to do.

```
brew install nginx
brew services start nginx
```

You will want to set it up so that you can type "https://pi.visualops.com" in your local
browser and it will access the web server with a certificate and do SSL.

```
ifconfig
```

Which might return:

```
...
inet 10.0.0.69
...
```

Now edit this file:

```
bbedit /etc/hosts
```

And type in a line at the end like this:

```
10.0.0.69 pi.visualops.com
```

We ship with a certificate (from letsencrypt) for pi.visualops.com which you can install with:

```
mkdir working
sudo mkdir /etc/letsencrypt/archive
sudo mkdir /etc/letsencrypt/live
nodes-web/ssl/install-pi-cert.sh
```

You can now create a config for nginx like this:

```
nodes-web/scripts/nginxconfmac.sh pi.visualops.com 443 80 `pwd`
```

That last argument is the folder where you are putting everything.

And now you can startup nodes and nodes-web like this:

```
nodes/scripts/start.sh nodes nodes pi.visualops.com
nodes-web/scripts/start.sh
```

After this you can visit "nodes" on the web with https://pi.visualops.com. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```

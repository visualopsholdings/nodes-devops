# Ubuntu 24.04

You can use these steps to setup a runtime (or development) system for Nodes in Ubuntu.

## Create a VM

Install Ubuntu on a VM, or on a machine.

This has been tested on an x86 VM in VirtualBox with the Ubuntu:

TBD

## Create a user

It is convenient for you to create a "nodes" user and use that rather than whatever user
you happened to log into Ubuntu with:

```
sudo adduser nodes
sudo adduser nodes sudo
echo "nodes ALL=(ALL) NOPASSWD:ALL" > nodes
sudo mv nodes /etc/sudoers.d/
sudo chown root:root /etc/sudoers.d/nodes
```

After this, you can either log onto your nodes user, or before executing scripts for nodes, type in

```
su nodes
```

## Download THIS project and navigate to the ubuntu scripts.

```
got clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops/ubuntu/24.04
```

## Installing our dependencies

You can install all the dependences with this command:

```
./x86-mongo.sh && ./install.sh
```

## Download and install the binary builds

You can find the latest builds in our github, and eventually they will be created according to the
many platforms we might build for, but for now they are just for THIS specific platform in AWS.

The "AWS-T2" build should run on any x86:

```
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.0.1/aws-t2-ubuntu-24_04.tgz
tar xzf aws-t2-ubuntu-24_04.tgz
mv aws-t2-ubuntu-24_04/nodes-lib .
mv aws-t2-ubuntu-24_04/nodes .
mv aws-t2-ubuntu-24_04/nodes-web .
mv aws-t2-ubuntu-24_04/nodes-irc .
rm -rf aws-t2-ubuntu-24_04*
```

That's it :-)

## create the mongoDB database

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@nodes.visualops.com "./mongo.sh"
```

## Start everything up

You can now start them up:

```
nodes/scripts/start.sh nodes nodes nodes.visualops.com
nodes-web/scripts/start.sh
nodes-irc/scripts/start.sh
```

## Hookup NGINX to Nodes stuff

If you visit your domain with https://nodes.visualops.com (or whatever yours is), you'll see a generic NGINX
welcome banner.

There are HTML files that are used by nodes, and the nodes program is a HTTP server itself running on
port 3000 that is meant to be "proxied" by nginx.

There are template files and a script inside the build that will create an appropriate NGINX config
file that you will put inside /etc/nginx/conf.d/default. Then when NGINX starts it
will use this config file.

```
nodes-web/scripts/nginxconf.sh nodes.visualops.com 443 80
```

Or whatever your domain is.

After this you can visit "nodes" on the web. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```


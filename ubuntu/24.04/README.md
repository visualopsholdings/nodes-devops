# Ubuntu 24.04

You can use these steps to setup a runtime (or development) system for Nodes in Ubuntu.

## Create a VM

Install Ubuntu on a VM, or on a machine.

This has been tested in the WSL (Subsystem for Linux) on windows.

## Create a user

It is convenient for you to create a "nodes" user and use that rather than whatever user
you happened to log into Ubuntu with:

If you actually used the user named "nodes", then you can ignore this step.

```
sudo adduser nodes
sudo adduser nodes sudo
```

Now make it simpler so you don't have to type a password when you sudo.

```
echo "nodes ALL=(ALL) NOPASSWD:ALL" > nodes
sudo mv nodes /etc/sudoers.d/
sudo chown root:root /etc/sudoers.d/nodes
```

After this, you can either log onto your nodes user, or before executing scripts for nodes, type in (
if your not alreaady user "nodes")

```
su nodes
```

## Download THIS project and navigate to the ubuntu scripts.

```
git clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops/ubuntu/24.04
```

## Installing our dependencies

You can install all the dependences with this command:

```
sudo apt-get -y install curl
./x86-mongo.sh
./install.sh
```

## Download and install the binary builds

You can find the latest builds in our github, and eventually they will be created according to the
many platforms we might build for, but for now they are just for THIS specific platform in AWS.

The "AWS-T2" build should run on any x86:

```
cd ~
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v.0.0.2/aws-t2-ubuntu-24_04.tgz
tar xzf aws-t2-ubuntu-24_04.tgz
mv aws-t2-ubuntu-24_04/nodes-lib .
mv aws-t2-ubuntu-24_04/nodes .
mv aws-t2-ubuntu-24_04/nodes-web .
mv aws-t2-ubuntu-24_04/nodes-irc .
rm -rf aws-t2-ubuntu-24_04*
```

That's it :-)

It's possible that when you run one of the binaries you find that it's missing teh exact libraries
for your slightly different Ubuntu version. If so, you can replace this step by downloading and building from source:

- https://github.com/visualopsholdings/nodes
- https://github.com/visualopsholdings/nodes-irc
- https://github.com/visualopsholdings/nodes-web

## create the mongoDB database

```
./mongo.sh
```

## Setup your VM so you can do SSL

This is a little complicated to do, but to simplify things we've made it possible to setup
your VM so you can visit "pi.visualops.com" locally and get a valid certificate.

On your network you need to make the name pi.visualops.com point to 192.168.0.240 (or whatever
your PI is). For now we are just going to edit your /etc/hosts file and put an entry in it.

Remember this is on the machines that you accessing your VM FROM. not the VM itself.
```
sudo nano /etc/hosts
```

And add this:

```
192.168.0.240  pi.visualops.com
```

Now you can install a certificate that matches that (it's supplied):

```
nodes-web/ssl/install-pi-cert.sh
```

## Start everything up

You can now start them up:

```
nodes/scripts/start.sh nodes nodes pi.visualops.com
nodes-web/scripts/start.sh
nodes-irc/scripts/start.sh
```

## Hookup NGINX to Nodes stuff

If you visit your domain with https://pi.visualops.com, you'll see a generic NGINX
welcome banner.

There are HTML files that are used by nodes, and the nodes program is a HTTP server itself running on
port 3000 that is meant to be "proxied" by nginx.

There are template files and a script inside the build that will create an appropriate NGINX config
file that you will put inside /etc/nginx/conf.d/default. Then when NGINX starts it
will use this config file.

```
nodes-web/scripts/nginxconf.sh pi.visualops.com 443 80
```

Or whatever your domain is.

After this you can visit "nodes" on the web. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```


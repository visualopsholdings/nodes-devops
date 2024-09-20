# AWS

You can use these steps to setup a runtime (or development) system for Nodes in AWS.

## Create a VM

Create an account in AWS, and then go to "EC2 / Instances" and click on the big orange
"Launch instances" button.

Type a useful name, click on "Ubuntu" in "Quick Start" and choose "Ubuntu Server 24.04 LTS",
which is probably the first one.

Choose "64-bit (Arm)" as the architecture, and "t4g.small" as the size.

You can also choose probably any architecture and size. We have tested the scripts below with

- 64-bit (Arm), t4g.small
- 64-bit (x86), t2.small

Note! If your going to do development work on it (like compile C++ projects), then make it larger!

Create yourself a new keypair, which you will use to login to the system when it's started. If 
you've done this before in this zone, you can just choose your existing keypair.

Create yourself a security group and check HTTP and HTTPS since you need these and then
make it a 16GB drive. Not that you need it but because of the way Nodes works it stores all
data for all nodes on every node so it's just easier to make it big enough now.

Now click the big orange "Launch instance" button and it will go off and create you a new
instance.

Every time this instance is rebooted it (may) get a new IP address so it's a good idea to
go back up to EC2 and choose "Elastic IPs". Click the orange "Allocate Elastic IP address" and
click the orange "Allocate" button.

Now choose the new allocated address (checkbox on left), and then on the "Actions" menu choose
"Associate Elastic IP address", and choose the instance you just created and click the orange
"Associate" button.

This new allocated address will be the address you will use to find your instance.

My address for this document is "13.236.72.83".

## Edit the port rules to allow IRC

Inside your VM, you need to edit the security rules to add port 6667 in.

Click on the checkbox next to your running VM and then click the "Security" tab. Just under
the heading "Security groups" you will see a link to your security group. Click on this
and you will be taken to that particular group.

Click the grey "Edit inbound rules" button, click the grey "Add rule" button and in "Port range"
type in 6667, and then choose "0.0.0.0/0" in the field with the magnifying glass.

Now click the orange "Save rules" button and you will be able to use IRC with this server.

## Logging onto your new instance

You downloaded your keypair to a file on your hard drive. I downloaded mine to 
"~/vopsDev/build/awskey-sydney.pem".

In your shell type this in:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem ubuntu@13.236.72.83
```

And your in :-)

## Navigate to where our scripts are for Ubuntu

```
cd nodes-devops/ubuntu/24.04
```

## Creating a new user

It's a really bad idea to just use the "ubuntu" or "root" or a predefined user for your
system. You want a brand new one. For all our scripts, our user is going to be "nodes".

```
scp -i ~/vopsDev/build/awskey-sydney.pem prep-user.sh ubuntu@13.236.72.83:
ssh -i ~/vopsDev/build/awskey-sydney.pem ubuntu@13.236.72.83 "prep-user.sh"
```

## Installing our dependencies

Copy the scripts over we need:

```
scp -i ~/vopsDev/build/awskey-sydney.pem *.sh ../../dev/*.sh nodes@13.236.72.83:
```

And run the initial scripts:

For ARM:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@13.236.72.83 "./arm64-mongo.sh && ./install.sh"
```

Or for Intel:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@13.236.72.83 "./x86-mongo.sh && ./install.sh"
```

## setup a domain and a certificate for your server

SSL is a necessary thing for Nodes. It is used by the Web and IRC interfaces and isn't optional.
Luckily it's very easy to setup.

In your domain name system (like GoDaddy etc), setup an A record to point a name to the address
you received.

So in our GoDaddy (visualops), I created an A record that said:

A | nodes | 13.236.72.83 | 1/2 Hour TTL

After this, I can access my server with:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@nodes.visualops.com
```

Now to create a certificate you can ask certbot to create you one.

```
sudo certbot --nginx --non-interactive --agree-tos --domains nodes.visualops.com --email admin@visualops.com
```

It's that easy. Make sure you put YOUR domain and a valid email address in. Don't use mine :-)

## Download and build the projects

At this point, if your building a development machine, you can replace this section with the instructions for 
building nodes from source. But continue for a binary only build (if there is one).

To build from source, visit each of these projects:

- https://github.com/visualopsholdings/nodes
- https://github.com/visualopsholdings/nodes-irc
- https://github.com/visualopsholdings/nodes-web

## Download and install the binary builds

You can find the latest builds in our github, and eventually they will be created according to the
many platforms we might build for, but for now they are just for THIS specific platform in AWS.

```
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.1.0/aws-tg4-ubuntu-24_04.tgz
tar xzf aws-tg4-ubuntu-24_04.tgz
mv aws-tg4-ubuntu-24_04/nodes-lib .
mv aws-tg4-ubuntu-24_04/nodes .
mv aws-tg4-ubuntu-24_04/nodes-web .
mv aws-tg4-ubuntu-24_04/nodes-irc .
rm -rf aws-tg4-ubuntu-24_04*
```

Or for Intel

```
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.1.0/aws-t2-ubuntu-24_04.tgz
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

First 2 arguments are the dbname and password.

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

After this you can visit "nodes" on the web https://nodes.visualops.com/apps/login To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```

To setup the server, use this manual:

[Operations manual](../manuals/OPERATIONS.md)

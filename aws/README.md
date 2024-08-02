# AWS

You can use these steps to setup a runtime (or development) system for Nodes in AWS.

## Create a VM

Create an account in AWS, and then go to "EC2 / Instances" and click on the big orange
"Launch instances" button.

Type a useful name, click on "Ubuntu" in "Quick Start" and choose "Ubuntu Server 24.04 LTS",
which is probably the first one.

Choose "64-bit (Arm)" as the architecture, and "t4g.small" as the size.

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

My address for this document is "13.54.94.134".

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
ssh -i ~/vopsDev/build/awskey-sydney.pem ubuntu@13.54.94.134
```

And your in :-)

## Creating a new user

It's a really bad idea to just use the "ubuntu" or "root" or a predefined user for your
system. You want a brand new one. For all our scripts, our user is going to be "nodes".

```
sudo adduser --disabled-password --gecos "" nodes
sudo adduser nodes sudo
```

Now make sure you can logon with the key your using now:

```
sudo cp -R .ssh /home/nodes
sudo chown -R nodes:nodes /home/nodes/.ssh
```

And make sure you don't have to type a password when you type sudo:

```
echo "nodes ALL=(ALL) NOPASSWD:ALL" > nodes
sudo mv nodes /etc/sudoers.d/
sudo chown root:root /etc/sudoers.d/nodes
```
Now if you exit, you can connect to ssh using your new user:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@13.54.94.134
```

Ok now we are all set to prepare this system for Nodes :-)

## Installing our dependencies

Copy the ubuntu install script to your new VM, logon to it and run the install script.

```
cd nodes-devops/ubuntu/24,04
scp -i ~/vopsDev/build/awskey-sydney.pem install.sh nodes@13.54.94.134:
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@13.54.94.134
./install.sh
```

# create the mongoDB database

First create the user you will use to login to the DB.

```
mongosh << EOF
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
EOF
```

And then you can populate the DB with some initial data.

```
cd nodes/mongodb
tar xzf initial.tgz
./restore.sh
```

# setup a domain and a certificate for your server

SSL is a necessary thing for Nodes. It is used by the Web and IRC interfaces and isn't optional.
Luckily it's very easy to setup.

In your domain name system (like GoDaddy etc), setup an A record to point a name to the address
you received.

So in our GoDaddy (visualops), I created an A record that said:

A | nodes | 13.54.94.134 | 1/2 Hour TTL

After this, I can access my server with:

```
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@nodes.visualops.com
```

Now to create a certificate you can ask certbot to create you one.

```
sudo certbot --nginx --non-interactive --agree-tos --domains nodes.visualops.com --email admin@visualops.com
```

It's that easy. Make sure you put YOUR domain and a valid email address in. Don't use mine :-)

# download and install the binary builds 

You can find the latest builds in our github, and eventually they will be created according to the
many platforms we might build for, but for now they are just for THIS specific platform in AWS.

```
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.0.1/nodes.tgz
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.0.1/nodes-irc.tgz
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.0.1/nodes-lib.tgz
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.0.1/nodes-web.tgz
tar xzf nodes-irc.tgz 
tar xzf nodes-web.tgz
tar xzf nodes-lib.tgz 
tar xzf nodes.tgz 
```

That's it :-)

You can now start them up:

```
nodes/scripts/start.sh nodes nodes nodes.visualops.com
nodes-web/scripts/start.sh
nodes-irc/scripts/start.sh
```

# Hookup NGINX to Nodes stuff

If you visit your domain with https://nodes.visualops.com (or whatever yours is), you'll see a generic NGINX
welcome banner.

There are HTML files that are used by nodes, and the nodes program is a HTTP server itself running on
port 3000 that is meant to be "proxied" by nginx.

There are template files and a script inside the build that will create an appropriate NGINX config
file that you will put inside /etc/nginx/conf.d/default. Then when NGINX starts it
will use this config file.

```
nodes/scripts/nginxconf.sh nodes.visualops.com 443 80
```

Or whatever your domain is.

After this you can visit "nodes" on the web. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```



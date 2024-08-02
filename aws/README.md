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
scp -i ~/vopsDev/build/awskey-sydney.pem ../ubuntu/24.04/install.sh nodes@13.54.94.134:
ssh -i ~/vopsDev/build/awskey-sydney.pem nodes@13.54.94.134
./install.sh 
```


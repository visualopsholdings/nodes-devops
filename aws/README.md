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

## setup a domain for your server

SSL is a necessary thing for Nodes. It is used by the Web and IRC interfaces and isn't optional.
Luckily it's very easy to setup.

In your domain name system (like GoDaddy etc), setup an A record to point a name to the address
you received.

So in our GoDaddy (visualops), I created an A record that said:

```
A | nodes | 13.236.72.83 | 1/2 Hour TTL
```

*Note: the address above is whatever $HOST is set to. The IP address of your VM.

You downloaded your keypair to a file on your hard drive. I downloaded mine to 
"~/vopsDev/build/awskey-sydney.pem".

Now setup some variables to make it easy:

```
export SSHKEY=~/vopsDev/build/awskey-sydney.pem
export HOST=nodes.visualops.com
export EMAIL=admin@visualops.com
export TAG=v0.3.0
```

The EMAIL is valid email address used when negotiating a new certificate
The TAG is the name of the TAG where the build exists.

## Logging onto your new instance

You can type this and see what you have so far :-)

```
ssh -i $SSHKEY ubuntu@$HOST
```

## Download and navigate to this project

Do this on the machine you are working on, not the actual VM. If your on windows
then it's easiest to install the WSL and do it from there:

```
git clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops
```

## Installing our software

For Intel:
```
aws/install-intel.sh $HOST $SSHKEY $EMAIL $TAG
```

For ARM:
```
aws/install-arm.sh $HOST $SSHKEY $EMAIL $TAG
```

After this you can visit "nodes" on the web https://nodes.visualops.com/apps/login To login, use the VID 

*Note nodes.visualops.com would be your hostname in $HOST

Use this as the VID.

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```

To setup the server, use this manual:

[Operations manual](../manuals/OPERATIONS.md)

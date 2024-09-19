# Raspberry PI 5

You can use these steps to setup a runtime (or development) system for Nodes on a Raspberry
PI 5.

Note that our code will work perfectly on a Pi4 BUT mongodb 7.0 which we use here crashes.
That problem could be solved by using a different version of mongoDB just for a pi4.

## Create an SSH key on your computer

If you already have an SSH key, then you can skip this. You can see if you have one with:

```
cat ~/.ssh/id_rsa.pub
```

If not, do this:

```
mkdir ~/.ssh
sudo chmod 700 ~/.ssh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

## Flash your memory card with the Ubuntu image

Launch the Raspberry PI Imager, put your SD card into your computer and burn the 
"Ubuntu Server 24.04" image to the card. You can find it under "Other general-purpose OS".

Click "Edit settings" and in "General", set your username and password to "nodes". You are turning off password access
so the password isn't important.

Set the Wifi details correctly so that the Raspberry PI will connect to your Wifi router and
you can find it after it boots.

In Services, enable "SSH" and then choose "Allow public-key authentication only" and paste
in the output of the "cat" command from before.

Click "YES" when asked to apply all these settings, "YES" to erase the media and burn your image.

After it burns, remove the card, put it in your Pi 5 and power it on.

## Finding and logging onto your PI

There are various ways to find your Pi, but the simplest is:

```
sudo arp-scan --localnet
```

Which will return something like:

```
Interface: en0, type: EN10MB, MAC: 3c:06:30:44:77:a1, IPv4: 192.168.0.196
Starting arp-scan 1.10.0 with 256 hosts (https://github.com/royhills/arp-scan)
192.168.0.1	1c:61:b4:61:9d:83	TP-Link Corporation Limited
192.168.0.13	d8:e0:e1:1b:6a:ba	Samsung Electronics Co.,Ltd
192.168.0.18	82:f0:45:3c:c9:7f	(Unknown: locally administered)
192.168.0.102	3c:a6:f6:8e:a3:69	Apple, Inc.
192.168.0.239	30:de:4b:13:9e:1a	TP-Link Corporation Limited
192.168.0.240	d8:3a:dd:cd:71:c9	Raspberry Pi Trading Ltd
192.168.0.240	d8:3a:dd:cd:71:c9	Raspberry Pi Trading Ltd (DUP: 2)
192.168.0.161	88:de:a9:74:a0:cf	Roku, Inc.
192.168.0.34	8c:4b:14:e6:c3:00	Espressif Inc.

546 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0: 256 hosts scanned in 1.834 seconds (139.59 hosts/sec). 8 responded
```

And you can see the raspberry pi is at 192.168.0.240, so logon to it:

```
ssh nodes@192.168.0.240
```

The first thing you want to do is to prevent anybody hacking your new Pi image, so you can
turn off password login and login as root:

Edit your config:

```
sudo nano /etc/ssh/sshd_config
```

Make these changes:

```
#PermitRootLogin prohibit-password
PermitRootLogin no
#PasswordAuthentication yes
PasswordAuthentication no
```

And then reboot and make sure you can login with ssh like above.

```
sudo shutdown -r now
```

Ok now we are all set to prepare this system for Nodes :-)

## Installing our dependencies

Copy the ubuntu install script to your new Pi, logon to it and run the install script.

```
git clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops/ubuntu/24.04
scp install.sh arm64-mongo.sh nodes@192.168.0.240:
ssh nodes@192.168.0.240
./arm64-mongo.sh
./install.sh
```


## Download and install the binary builds

You can find the latest builds in our github:

You could also build the projects from scratch ON your PI but you will need an 8GB PI to do this. These
builds will happily run on a 2GB pi 5 (and even a 3 and 4 but we have yet to test that).

```
wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.1.0/pi-ubuntu-24_04.tgz
tar xzf pi-ubuntu-24_04.tgz
mv pi-ubuntu-24_04/nodes-lib .
mv pi-ubuntu-24_04/nodes .
mv pi-ubuntu-24_04/nodes-web .
mv pi-ubuntu-24_04/nodes-irc .
rm -rf pi-ubuntu-24_04*
```

That's it :-)

## create the mongoDB database

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
cd ../..
```

## Setup your PI so you can do SSL

This is a little complicated to do, but to simplify things we've made it possible to setup
your pi so you can visit "local.visualops.com" locally and get a valid certificate.

On your network you need to make the name local.visualops.com point to 192.168.0.240 (or whatever
your PI is). For now we are just going to edit your /etc/hosts file and put an entry in it.

```
sudo nano /etc/hosts
```

And add this:

```
192.168.0.240  local.visualops.com
```

Now you can install a certificate that matches that (it's supplied):

```
nodes-web/ssl/install-local-cert.sh
```

## Start everything up

You can now start them up:

```
nodes/scripts/start.sh nodes nodes local.visualops.com
nodes-web/scripts/start.sh
nodes-irc/scripts/start.sh
```

## Hookup NGINX to Nodes stuff

If you visit your domain with https://local.visualops.com, you'll see a generic NGINX
welcome banner.

There are HTML files that are used by nodes, and the nodes program is a HTTP server itself running on
port 3000 that is meant to be "proxied" by nginx.

There are template files and a script inside the build that will create an appropriate NGINX config
file that you will put inside /etc/nginx/conf.d/default. Then when NGINX starts it
will use this config file.

```
nodes-web/scripts/nginxconf.sh local.visualops.com 443 80
```

Or whatever your domain is.

After this you can visit "nodes" on the web. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```



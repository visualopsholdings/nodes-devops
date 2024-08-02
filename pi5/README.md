# Raspberry PI 5

You can use these steps to setup a runtime (or development) system for Nodes on a Raspberry
PI 5.

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
192.168.0.156	d8:3a:dd:cd:71:c9	Raspberry Pi Trading Ltd
192.168.0.156	d8:3a:dd:cd:71:c9	Raspberry Pi Trading Ltd (DUP: 2)
192.168.0.161	88:de:a9:74:a0:cf	Roku, Inc.
192.168.0.34	8c:4b:14:e6:c3:00	Espressif Inc.

546 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0: 256 hosts scanned in 1.834 seconds (139.59 hosts/sec). 8 responded
```

And you can see the raspberry pi is at 192.168.0.156, so logon to it:

```
ssh nodes@192.168.0.156
```

The first thing you want to do is to prevent anybody hacking your noce new Pi image, so you can
turn off password login and being able to login as root:

Edit your config:

```
nano /etc/ssh/sshd_config
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

Copy the ubuntu install script to your new VM, logon to it and run the install script.

```
cd nodes-devops/ubuntu/24.04
scp install.sh arm64-mongo.sh nodes@192.168.0.156:
ssh nodes@192.168.0.156
./arm64-mongo.sh
./install.sh
```





# Windows

You can use these steps to setup a runtime (or development) system for Nodes on a Windows
machine.

The basic process is that all of the developed code is built in Ubuntu like all our other platforms
using the "Windows Subsystem for Linux" or WSL.

This runs Ubuntu as a VM alongside your Windows OS, and there is a great plugin inside Visual Studio
that let's you use a shell to get to this and access the files that are in that VM.

Since MongoDB doesn't work in the WSL, you run that seperately as a normal Windows process and access
it remotely using the IP address of the host.

## Prerequisites

### WSL

Run Windows Powershell as Administrator and then run this:

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

This will restart your computer.

Now go to the Microsoft Store and type "Ubuntu" and choose "22.04.3 LTS" install it. When you run it
you might get an error saying to install a new kernel package. You can find that here:

https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

You might also have virtualization disabled in your bios:

https://aka.ms/enablevirtualization

I also needed to follow this to get WSL working:

https://superuser.com/questions/1748953/cannot-run-wsl-on-acer-5-2022

When you finally run it, choose "nodes" as the username and password.

### Visual Studio Code

You can get this from the Microsoft Store, and then set it up so that it can be used
to develop in the Ubuntu you installed.

https://code.visualstudio.com/docs/remote/wsl

After this is installed, you can conveniently connect to the WSL and use the terminal
to do the remaining steps.

## Setup your user for sudo

Now make it simpler so you don't have to type a password when you sudo.

Inside the WSL terminal:
```
echo "nodes ALL=(ALL) NOPASSWD:ALL" > nodes
sudo mv nodes /etc/sudoers.d/
sudo chown root:root /etc/sudoers.d/nodes
```

If you didn't use "nodes" as your user, then change "nodes" above to be whatever user you have created.

## .gitconfig

Make sure your .gitconfig doesn't have anything wierd in it. It can be empty for now or you can
just make sure your details are correct.

```
[user]
      name = Paul Hamilton
      email = paul@visualops.com
```
      
## Download THIS project and navigate to the ubuntu scripts.

Inside the WSL terminal:
```
git clone https://github.com/visualopsholdings/nodes-devops
cd nodes-devops/ubuntu/24.04
```

## Installing our dependencies

You can install all the dependences with this command:

Inside the WSL terminal:
```
./install-nomongo.sh
```

### Node is too old

To use the build tools in nodes-web (for a full build), you will need a later version of node, which you can get here:

Inside the WSL terminal:
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
. ~/.bashrc
nvm install v16.14
```


## Download and install the binary builds

You can find the latest builds in our github.

Inside the WSL terminal:
```
cd ~

wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.3.0/wsl-ubuntu-24_04.tgz
tar xzf wsl-ubuntu-24_04.tgz
mv wsl-ubuntu-24_04/nodes-lib .
mv wsl-ubuntu-24_04/nodes .
mv wsl-ubuntu-24_04/nodes-web .
mv wsl-ubuntu-24_04/nodes-irc .
rm -rf wsl-ubuntu-24_04*
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

Download and install MongoDB for windows:

https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-7.0.14-signed.msi

Just double click on the downloade MSI to run the installer.

Use "Complete" and take the defaults for how to set it up a service. Install "Compass"
as well because it's really useful.

https://fastdl.mongodb.org/tools/db/mongodb-database-tools-windows-x86_64-100.10.0.zip

Unzip these, and then copy everything inside "bin" into 'C:\Program Files\MongoDB\Server\7.0\bin'.

The installed mongodb from our instructions doesn't work from inside WSL so you install mongodb externally in windows itself and then we will explain how to do the mongo steps we need here on the MongoDB which is actually running external to WSL.

By default, MongoDB binds to the local interface (127.0.0.1) so it can't be seen by WSL, but you can
change that.

From inside Ubuntu in WSL, this command will show you the host address for your windows
machine:

Inside the WSL terminal:
```
ip route show | grep -i default | awk '{ print $3}'
```

For example, this might return "10.0.0.27"

Now edit this file with visual studio:

```
C:\\Program Files\MongoDB\Server\7.0\bin\mongod.cfg
```

Find "bindIp: 127.0.0.1" and change it to "bindIp: 10.0.0.27". The 10.0.0.27 is the address that was returned in the
command above.

Now restart MongoDB using the windows powershell as Admin:

Inside the Windows PowerShell:
```
start-process powershell -verb runas
```

This will create a new "blue" powershell.

Inside this you can stop and start MongoDB:

```
net stop MongoDB
net start MongoDB
```

#### Populate MongoDB

Run "Compass" and and connect to the database.

Remember to change the connection string to your external address that you found in the previous step rather
rather than localhost.

If your external address of WSL was "10.0.0.27", then your connection string would be:

```
mongodb://10.0.0.27:27017/
```

Down the bottom there is a dark blue window you can expand that gives you direct access to the mongo shell. 

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

Inside the WSL terminal:
```
cd nodes/mongodb
tar xzf initial.tgz
```

And then restore it into the DB in Windows (so in the powershell or command prompt in Windows):

Inside the PowerShell:
```
cd 'C:\Program Files\MongoDB\Server\7.0\bin'
./mongorestore --username=nodes --password=nodes --db=nodes --drop \\wsl.localhost\Ubuntu-22.04\home\nodes\nodes\mongodb\dump\fiveEstellas
```
*** This doesn't workj at the moment, we need to specificy the connectin string that we worked out above.

Conveniently, you can get to your WSL data from windows at this path (as seen above):

```
\\wsl.localhost\Ubuntu-22.04\home\nodes
```

### Windows Firewall

You will need to turn the firewall off (public) or add port 27017 as an exception in
the advanced settings.

### NgINX

Now that everything starts up, you want to be able to access nodes from the browser and there
are a few steps still to do.

You will want to set it up so that you can type "https://local.visualops.com" in your local
browser and it will access the web server with a certificate and do SSL.

Find the IP address of your WSL:

Inside the WSL terminal:
```
ifconfig
```

Which might return:

```
...
inet 172.20.69.63
...
```

Now edit this file with Visual Studio:

```
C:\Windows\System32\drivers\etc\hosts
```

And type in a line at the end like this:

```
172.20.69.63 local.visualops.com
```

We ship with a certificate (from letsencrypt) for local.visualops.com which you can install with:

Inside the WSL terminal:
```
sudo mkdir /etc/letsencrypt/archive
sudo mkdir /etc/letsencrypt/live
nodes-web/ssl/install-local-cert.sh
```

You can now create a config for nginx like this:

Inside the WSL terminal:
```
nodes-web/scripts/nginxconf.sh local.visualops.com 443 80
```

And now you can startup nodes and nodes-web like this:

Inside the WSL terminal:
```
nodes/scripts/start.sh nodes nodes local.visualops.com 10.0.0.27
nodes-web/scripts/start.sh
```

10.0.0.27 is the address where you can find MongoDB.

Now startup NGINX:

Inside the WSL terminal:
```
sudo nginx
```

You can stop it with this:

Inside the WSL terminal:
```
sudo nginx -s stop
```

After this you can visit "nodes" on the web with https://local.visualops.com/apps/login. To login, use the VID 

```
Vk9WNIdltNaXa0eOG9cAdmlzdWFsb3Bz
```

To setup the server, use this manual:

[Operations manual](../manuals/OPERATIONS.md)

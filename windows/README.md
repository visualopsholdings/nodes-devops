# Windows 11

You can use these steps to setup a runtime (or development) system for Nodes on a Windows 11
machine.

The basic process is that all of the developed code is built in Ubuntu like all our other platforms
using the "Windows Subsystem for Linux" or WSL.

This runs Ubuntu as a VM alongside your Windows OS, and there is a great plugin inside Visual Studio
that let's you use a shell to get to this and access the files that are in that VM.

Since MongoDB doesn't work in the WSL, you run that seperately as a normal Windows process and access
it remotely using the IP address of the host.

## Prerequisits

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

You can now follow the instructions in:

[Setting up for Ubuntu 24.04](../ubuntu/24.04/README.md)

Just ignore the very first part about creating a user, since your user is already "nodes".

### Visual Studio Code

You can get this from the Microsoft Store, and then set it up so that it can be used
to develop in teh Ubuntu you installed.

https://code.visualstudio.com/docs/remote/wsl

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

```
ip route show | grep -i default | awk '{ print $3}'
```

For example, this might return "172.30.192.1"

Now edit this file with a text editor:

```
C:\\Program Files\MongoDB\Server\7.0\bin\mongod.cfg
```

Find "bindIp: 127.0.0.1" and change it to "bindIp: 172.30.192.1"

Now restart MongoDB using the windows powershell as Admin:

```
start-process powershell -verb runas
```

Inside this you can stop and start MongoDB:

```
net stop MongoDB
net start MongoDB
```

Run "Compass" and down the bottom there is a dark blue window you can expand that gives you
direct access to the mongo shell. 

Remember to change the connection string to your external
address rather than localhost.

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

Extract the initial DB contents inside WSL:

```
cd nodes/mongodb
tar xzf initial.tgz
```

And then restore it into the DB in Windows:

```
cd 'C:\Program Files\MongoDB\Server\7.0\bin'
./mongorestore --username=nodes --password=nodes --db=nodes --drop \\wsl.localhost\Ubuntu-22.04\home\nodes\nodes\mongodb\dump\fiveEstellas
```

### Node is too old

To use the build tools in nodes-web, you will need a later version of node, which you can get 
here:

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
. ~/.bashrc
nvm install v16.14
```


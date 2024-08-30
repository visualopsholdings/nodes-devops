# Windows 11

You can use these steps to setup a runtime (or development) system for Nodes on a Windows 11
machine.

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

[Setting up for Ubuntu 24.02](../ubuntu/24.04/README.md)

Just ignore the very first part about creating a user, since your user is already "nodes".

### Visual Studio Code

You can get this from the Microsoft Store, and then set it up so that it can be used
to develop in teh Ubuntu you installed.

https://code.visualstudio.com/docs/remote/wsl

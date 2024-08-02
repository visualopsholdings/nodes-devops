# nodes-devops

DevOps related scripts and data for Nodes.

# Related Projects

- https://github.com/visualopsholdings/nodes
- https://github.com/visualopsholdings/nodes-irc
- https://github.com/visualopsholdings/nodes-web

# Current development system

The current development system (CI) is hosted in AWS as a t4g.xlarge in the Sydney region.

This runs Ubuntu 22.04, has 4 CPUs and 16GB of disk space and is arm64 architecture.

The reason it is so large is because as a development system it has to build all of boost
and other tools and just takes that much CPU.

These scripts and steps will obviously work on any CPU architecture (like ARM) but for 
specifics we will outline how to build for Ubuntu 22.04, t4g.small, on ARM with 16GB of 
disk space.

The scripts will copy binary files rather than do builds since our development system 
is building these.

In future the method will be the same for our systems. We will have whatever development
system is REQUIRED to do build from source, and then produce working steps for a tiny
machine using binary artifacts.

[Setting up for AWS](aws/README.md)

To setup a development system, use the above first and then follow the steps in the github repo
to install the various sources for the dependencies.
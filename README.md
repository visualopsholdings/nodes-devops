
# Nodes

A system for delivering JSON messages amongst a tree of servers using ZMQ.

## Visual Ops

Visual Ops is a messaging system (and more) that exists on the edge. Visual Ops nodes are
standalone servers which can be formed into a tree of servers delivering new messages to users
using ZMQ message queues and (in the web) Web sockets.

- There is a full featured Web App which can be configured as a standalone app on iOS and Android
and any device that can run a browser.
- Messages persist in a MongoDB database.
- A security system allows subsets of users to View and Edit "Streams" which are analagous to Channels
in IRC.
- A system called "Nodes" correctly delivers missing messages when nodes "go away".
- The system uses ZMQ message queues in a novel fashion which are the backbone for delivery
and use EC (Eliptical Curve) Cryptography to ensure transport security.
- Visual Ops is monolithic. Every server is completely standalone and require no more resources
from the internet (Cloud).

For these reasons, it would be the perfect backend for IRC Clients, or other messaging systems and solve many of the existing drawbacks
and problems that plague IRC etc.

This project implements an open source implementation of this in C++.

## Related Projects

### https://github.com/visualopsholdings/nodes

The core subsystem for deliverying the messages, synchronizing nodes etc.

### https://github.com/visualopsholdings/nodes-irc

An IRC component that handles the transfer of messages from IRC based clients to Nodes.

### https://github.com/visualopsholdings/nodes-web

A Web component that does RESTful requests, sockets, etags and all web things communicating
with the Nodes subsystem.

## Current development system

The current development system (CI) is hosted in AWS as a t4g.xlarge in the Sydney region.

This runs Ubuntu 22.04, has 4 CPUs and 16GB of disk space and is arm64 architecture.

The reason it is so large is because as a development system it has to build all of boost
and other tools and just takes that much CPU.

These scripts and steps will obviously work on any CPU architecture (like ARM) but for 
specifics we will outline how to build for Ubuntu 22.04, (t4g/t2).small, on ARM or X86 with 16GB of 
disk space.

The scripts will copy binary files rather than do builds since our development system 
is building these.

In future the method will be the same for our systems. We will have whatever development
system is REQUIRED to do build from source, and then produce working steps for a tiny
machine using binary artifacts.

[Setting up for AWS](aws/README.md)

[Setting up for Raspberry PI 5](pi5/README.md)

[Setting up for Ubuntu 24.04 but in Windows](windows/README.md)

[Setting up for Mac OS](mac/README.md)

To setup a development system, use the above first and then follow the steps in the github repo
to install the various sources for the dependencies.

## Manuals

[Operations manual](manuals/OPERATIONS.md)
[IRC](manuals/IRC.md)

#!/bin/bash
# 
# Create our "nodes" user

# add the user
sudo adduser --disabled-password --gecos "" nodes
sudo adduser nodes sudo

# Now make sure you can logon with the key your using now
sudo cp -R .ssh /home/nodes
sudo chown -R nodes:nodes /home/nodes/.ssh

# And make sure you don't have to type a password when you type sudo:
echo "nodes ALL=(ALL) NOPASSWD:ALL" > nodes
sudo mv nodes /etc/sudoers.d/
sudo chown root:root /etc/sudoers.d/nodes

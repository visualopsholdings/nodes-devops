#!/bin/bash
# 
# Install things for Ubuntu 24.04
#
# - mongodb
# - haproxy
# - certbot
# - memcached

# all our prereqs
sudo apt-get update
sudo apt-get -y install g++ gcc make \
  memcached haproxy libkrb5-dev zip libmemcached-dev zlib1g-dev \
  mongodb-org certbot python3-certbot-nginx python3-pip

sudo apt -y autoremove

sudo systemctl enable mongod
sudo systemctl start mongod

# disable snapd
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded
sudo systemctl disable snapd.snap-repair.timer

# turn off auto upgrades!
sudo dpkg-reconfigure --priority=low unattended-upgrades -fnoninteractive

# add nodes to the www-data group (for nginx)
sudo gpasswd -a www-data nodes

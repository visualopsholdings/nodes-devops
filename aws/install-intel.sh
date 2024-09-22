#!/bin/bash
# 
# AWS install script for intel

if [ "$#" -lt 2 ]; then
	echo "usage: $0 HOST EMAIL"
	exit 1
fi

HOST=$1
EMAIL=$2

# Initial dependencies
./install/x86-mongo.sh && ./install/install.sh

# Download our code from github
./install/download-intel.sh

# configure it
./install/config.sh $HOST $EMAIL

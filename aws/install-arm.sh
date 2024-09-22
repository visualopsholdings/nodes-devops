#!/bin/bash
# 
# AWS install script for arm

if [ "$#" -lt 2 ]; then
	echo "usage: $0 HOST EMAIL"
	exit 1
fi

HOST=$1
EMAIL=$2

# Initial dependencies
./install/arm64-mongo.sh && ./install/install.sh

# Download our code from github
./install/download-arm.sh

# configure it
./install/config.sh $HOST $EMAIL

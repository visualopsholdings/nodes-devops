#!/bin/bash
# 
# AWS install script for arm

if [ "$#" -lt 3 ]; then
	echo "usage: $0 HOST EMAIL TAG"
	exit 1
fi

HOST=$1
EMAIL=$2
TAG=$3

# Initial dependencies
./install/arm64-mongo.sh && ./install/install.sh

# Download our code from github
./install/download.sh aws-t4g-ubuntu-24_04 $TAG

# configure it
./install/config.sh $HOST $EMAIL

#!/bin/bash
# 
# AWS install script for arm

if [ "$#" -lt 4 ]; then
	echo "usage: $0 HOST SSHKEY EMAIL TAG"
	exit 1
fi

if [ ! -d "aws" ]; then
	echo "usage: this script needs to be run from the root of the node-devops folder."
	exit 1
fi

HOST=$1
SSHKEY=$2
EMAIL=$3
TAG=$4

./aws/init.sh $HOST

# Initial dependencies
ssh -i $SSHKEY nodes@$HOST "./install/arm64-mongo.sh && ./install/install.sh"

# Download our code from github
ssh -i $SSHKEY nodes@$HOST "./install/download.sh aws-t4g-ubuntu-24_04 $TAG"

# configure it
ssh -i $SSHKEY nodes@$HOST "./install/config.sh $HOST $EMAIL"

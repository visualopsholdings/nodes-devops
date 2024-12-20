#!/bin/bash
# 
# AWS upgrade script for arm

if [ "$#" -lt 3 ]; then
	echo "usage: $0 HOST SSHKEY TAG"
	exit 1
fi

if [ ! -d "aws" ]; then
	echo "usage: this script needs to be run from the root of the node-devops folder."
	exit 1
fi

HOST=$1
SSHKEY=$2
TAG=$3

# stop the server
ssh -i $SSHKEY nodes@$HOST "./stopall.sh"

# copy over the scripts we need.
scp -i $SSHKEY aws/download.sh nodes@$HOST:install

# Download our code from github
ssh -i $SSHKEY nodes@$HOST "./install/download.sh aws-t4g-ubuntu-24_04 $TAG"

# start the server
ssh -i $SSHKEY nodes@$HOST "./startall.sh"


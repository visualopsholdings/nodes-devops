#!/bin/bash
# 
# AWS upgrade script for intel

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

# copy over the scripts we need.
scp -i $SSHKEY aws/download.sh nodes@$HOST:install

# Download our code from github
ssh -i $SSHKEY nodes@$HOST "./install/download.sh aws-t2-ubuntu-24_04 $TAG"

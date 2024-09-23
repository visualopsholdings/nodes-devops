#!/bin/bash
# 
# do initial steps to setup an AWS ubuntu server

if [ "$#" -lt 1 ]; then
	echo "usage: $0 HOST"
	exit 1
fi

HOST=$1
# create the node user.
# It's a really bad idea to just use the "ubuntu" or "root" or a predefined user for your
# system. You want a brand new one. For all our scripts, our user is going to be "nodes".
scp -i $SSHKEY ubuntu/24.04/prep-user.sh ubuntu@$HOST:
ssh -i $SSHKEY ubuntu@$HOST "./prep-user.sh"

# copy over the scripts we need.
scp -i $SSHKEY aws/download.sh aws/config.sh ubuntu/24.04/*.sh nodes@$HOST:install

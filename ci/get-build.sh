#!/bin/bash
#

if [ "$#" -lt 3 ]; then
	echo "usage: $0 HOST KEY ARCH"
	exit 1
fi

HOST=$1
KEY=$2
ARCH=$3

ssh -i $KEY $HOST "cd nodes-devops/ci; ./cpall.sh $ARCH"
scp -i $KEY $HOST:$ARCH.tgz .

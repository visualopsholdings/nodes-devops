#!/bin/bash
#

if [ "$#" -lt 1 ]; then
	echo "usage: $0 TAG"
	exit 1
fi

TAG=$1

pushd ..
aws/upgrade-arm.sh nodestest.visualops.com ~/vopsDev/build/awskey-us-west.pem $TAG
popd

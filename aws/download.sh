#!/bin/bash
# 
# Download a build from github

if [ "$#" -lt 2 ]; then
	echo "usage: $0 ARCH TAG"
	exit 1
fi

ARCH=$1
TAG=$2

./stopall.sh

# cleanup
rm -rf nodes-lib nodes nodes-web nodes-irc

wget https://github.com/visualopsholdings/nodes-devops/releases/download/$TAG/$ARCH.tgz
tar xzf $ARCH.tgz
mv $ARCH/nodes-lib .
mv $ARCH/nodes .
mv $ARCH/nodes-web .
mv $ARCH/nodes-irc .
rm -rf $ARCH*

./startall.sh

#!/bin/bash
#

if [ "$#" -lt 2 ]; then
	echo "usage: $0 ARCH FOLDER"
	exit 1
fi

ARCH=$1
FOLDER=$2

rm -rf $FOLDER/$ARCH/nodes-irc
mkdir $FOLDER/$ARCH/nodes-irc
mkdir $FOLDER/$ARCH/nodes-irc/build
mkdir $FOLDER/$ARCH/nodes-irc/scripts

get() {
  cp $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

getfolder() {
  cp -r $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

get nodes-irc/build nodes-irc

getfolder nodes-irc scripts

# don't want this.
rm $FOLDER/$ARCH/nodes-irc/scripts/build.sh

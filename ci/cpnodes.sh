#!/bin/bash
#

if [ "$#" -lt 3 ]; then
	echo "usage: $0 ARCH FOLDER LIBEXT"
	exit 1
fi

ARCH=$1
FOLDER=$2
LIBEXT=$3

echo "Cleaning $ARCH"
rm -rf $FOLDER/$ARCH

mkdir $FOLDER/$ARCH
mkdir $FOLDER/$ARCH/nodes
mkdir $FOLDER/$ARCH/nodes/build
mkdir $FOLDER/$ARCH/nodes/scripts
mkdir $FOLDER/$ARCH/nodes/mongodb

get() {
  cp $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

getfolder() {
  cp -r $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

get nodes/build nodes
get nodes/build nodesaggregate
get nodes/build libStorageLib.$LIBEXT

getfolder nodes scripts
getfolder nodes mongodb

# don't want this.
rm $FOLDER/$ARCH/nodes/scripts/build.sh

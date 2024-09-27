#!/bin/bash
#

if [ "$#" -lt 2 ]; then
	echo "usage: $0 ARCH FOLDER"
	exit 1
fi

ARCH=$1
FOLDER=$2

rm -rf $FOLDER/$ARCH/nodes-lib
mkdir $FOLDER/$ARCH/nodes-lib

get() {
  cp $1 $FOLDER/$ARCH/$2
}

get /usr/local/lib/libmongocxx._noabi.dylib nodes-lib
get /usr/local/lib/libbsoncxx._noabi.dylib nodes-lib
get /usr/local/lib/libmongoc-1.0.0.dylib nodes-lib
get /usr/local/lib/libbson-1.0.0.dylib nodes-lib
get /opt/homebrew/Cellar/snappy/1.2.1/lib/libsnappy.1.2.1.dylib nodes-lib
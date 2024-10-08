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

getboost() {
  get /usr/lib/$1.so.1.85.0 nodes-lib
}

getlib() {
  get /usr/local/lib/$1 nodes-lib
}

getboost libboost_program_options
getboost libboost_log
getboost libboost_filesystem
getboost libboost_thread
getboost libboost_chrono
getboost libboost_json
getlib libzmq.so.5
getlib libmongocxx.so._noabi
getlib libbsoncxx.so._noabi
getlib libmongoc-1.0.so.0
getlib libbson-1.0.so.0

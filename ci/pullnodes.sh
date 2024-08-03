
if [ "$#" -ne 3 ]; then
	echo "usage: $0 HOST KEY ARCH"
	exit 1
fi

HOST=$1
KEY=$2
ARCH=$3

echo "Cleaning $ARCH"
rm -rf $ARCH

mkdir $ARCH
mkdir $ARCH/nodes
mkdir $ARCH/nodes/build
mkdir $ARCH/nodes/scripts
mkdir $ARCH/nodes/mongodb

get() {
  scp -i $KEY $HOST:$1/$2 $ARCH/$1
}

getfolder() {
  ssh -i $KEY $HOST "cd $1; tar czf ../$1-$2.tgz $2"
  scp -i $KEY $HOST:$1-$2.tgz $ARCH/$1
  pushd $ARCH/$1
  tar xzf $1-$2.tgz
  rm -rf $1-$2.tgz
  popd
}

get nodes/build nodes
get nodes/build nodesaggregate
get nodes/build libStorageLib.so

getfolder nodes scripts
getfolder nodes mongodb

# don't want this.
rm $ARCH/nodes/scripts/build.sh

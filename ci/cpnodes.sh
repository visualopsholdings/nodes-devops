
if [ "$#" -ne 1 ]; then
	echo "usage: $0 ARCH"
	exit 1
fi

ARCH=$1

echo "Cleaning $ARCH"
rm -rf ~/$ARCH

mkdir ~/$ARCH
mkdir ~/$ARCH/nodes
mkdir ~/$ARCH/nodes/build
mkdir ~/$ARCH/nodes/scripts
mkdir ~/$ARCH/nodes/mongodb

get() {
  cp ~/$1/$2 ~/$ARCH/$1
}

getfolder() {
  cp -r ~/$1/$2 ~/$ARCH/$1
}

get nodes/build nodes
get nodes/build nodesaggregate
get nodes/build libStorageLib.so

getfolder nodes scripts
getfolder nodes mongodb

# don't want this.
rm ~/$ARCH/nodes/scripts/build.sh

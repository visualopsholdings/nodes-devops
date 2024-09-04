
if [ "$#" -lt 1 ]; then
	echo "usage: $0 ARCH FOLDER"
	exit 1
fi

ARCH=$1

if [ "$#" -eq 2 ]; then
  FOLDER=$2
else
  FOLDER=~
fi

./cpnodes.sh $ARCH $FOLDER dylib
[ "$?" != "0" ] && exit 1

./cpweb.sh $ARCH $FOLDER
[ "$?" != "0" ] && exit 1

./cpirc.sh $ARCH $FOLDER
[ "$?" != "0" ] && exit 1

pushd $FOLDER
tar czf $ARCH.tgz $ARCH
popd


if [ "$#" -ne 1 ]; then
	echo "usage: $0 ARCH"
	exit 1
fi

ARCH=$1

./cpnodes.sh $ARCH
[ "$?" != "0" ] && exit 1

./cpweb.sh $ARCH
[ "$?" != "0" ] && exit 1

./cpirc.sh $ARCH
[ "$?" != "0" ] && exit 1

./cplibs.sh $ARCH
[ "$?" != "0" ] && exit 1

pushd ~
tar czf $ARCH.tgz $ARCH
popd

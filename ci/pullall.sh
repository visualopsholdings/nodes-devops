
if [ "$#" -ne 3 ]; then
	echo "usage: $0 HOST KEY ARCH"
	exit 1
fi

HOST=$1
KEY=$2
ARCH=$3

./pullnodes.sh $HOST $KEY $ARCH
[ "$?" != "0" ] && exit 1

./pullweb.sh $HOST $KEY $ARCH
[ "$?" != "0" ] && exit 1

./pullirc.sh $HOST $KEY $ARCH
[ "$?" != "0" ] && exit 1

./pulllibs.sh $HOST $KEY $ARCH
[ "$?" != "0" ] && exit 1

tar czf $ARCH.tgz $ARCH
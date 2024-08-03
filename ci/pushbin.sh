
if [ "$#" -ne 4 ]; then
	echo "usage: $0 UNAME HOST KEY ARCH"
	exit 1
fi

UNAME=$1
HOST=$2
KEY=$3
ARCH=$4

if [ "$KEY" != "none" ];
then
  CERT="-i $KEY"
fi

if [ ! -d $ARCH ];
then
  echo "use pullbin.sh first."
  exit 1
fi

rm -rf $ARCH.tgz
tar czf $ARCH.tgz $ARCH

scp $CERT $ARCH.tgz $UNAME@$HOST:
ssh $CERT $UNAME@$HOST "rm -rf $ARCH; tar xzf $ARCH.tgz"
ssh $CERT $UNAME@$HOST "rm -rf nodes-lib; mv $ARCH/nodes-lib ."
ssh $CERT $UNAME@$HOST "nodes/scripts/stop.sh"
ssh $CERT $UNAME@$HOST "nodes-web/scripts/stop.sh"
ssh $CERT $UNAME@$HOST "nodes-irc/scripts/stop.sh"
ssh $CERT $UNAME@$HOST "rm -rf nodes; mv $ARCH/nodes .; nodes/scripts/start.sh nodes nodes $HOST"
ssh $CERT $UNAME@$HOST "rm -rf nodes-web; mv $ARCH/nodes-web .; nodes-web/scripts/start.sh"
ssh $CERT $UNAME@$HOST "rm -rf nodes-irc; mv $ARCH/nodes-irc .; nodes-irc/scripts/start.sh"
ssh $CERT $UNAME@$HOST "rm -rf $ARCH $ARCH.tgz"

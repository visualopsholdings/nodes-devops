
if [ "$#" -ne 3 ]; then
	echo "usage: $0 HOST KEY ARCH"
	exit 1
fi

HOST=$1
KEY=$2
ARCH=$3

if [ "$KEY" != "none" ];
then
  CERT="-i $KEY"
fi

rm -rf $ARCH/nodes-irc
mkdir $ARCH/nodes-irc
mkdir $ARCH/nodes-irc/build
mkdir $ARCH/nodes-irc/scripts

get() {
  scp $CERT $HOST:$1/$2 $ARCH/$1
}

getfolder() {
  ssh $CERT $HOST "cd $1; tar czf ../$1-$2.tgz $2"
  scp $CERT $HOST:$1-$2.tgz $ARCH/$1
  pushd $ARCH/$1
  tar xzf $1-$2.tgz
  rm -rf $1-$2.tgz
  popd
}

get nodes-irc/build nodes-irc

getfolder nodes-irc scripts

# don't want this.
rm $ARCH/nodes-irc/scripts/build.sh

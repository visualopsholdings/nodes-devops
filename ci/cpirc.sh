
if [ "$#" -ne 1 ]; then
	echo "usage: $0 ARCH"
	exit 1
fi

ARCH=$1

rm -rf ~/$ARCH/nodes-irc
mkdir ~/$ARCH/nodes-irc
mkdir ~/$ARCH/nodes-irc/build
mkdir ~/$ARCH/nodes-irc/scripts

get() {
  cp ~/$1/$2 ~/$ARCH/$1
}

getfolder() {
  cp -r ~/$1/$2 ~/$ARCH/$1
}

get nodes-irc/build nodes-irc

getfolder nodes-irc scripts

# don't want this.
rm ~/$ARCH/nodes-irc/scripts/build.sh


if [ "$#" -ne 1 ]; then
	echo "usage: $0 ARCH"
	exit 1
fi

ARCH=$1

rm -rf ~/$ARCH/nodes-web
mkdir ~/$ARCH/nodes-web
mkdir ~/$ARCH/nodes-web/build
mkdir ~/$ARCH/nodes-web/scripts

get() {
  cp ~/$1/$2 ~/$ARCH/$1
}

getfolder() {
  cp -r ~/$1/$2 ~/$ARCH/$1
}

get nodes-web/build nodes-web

getfolder nodes-web scripts
getfolder nodes-web ssl
getfolder nodes-web frontend

# don't want this.
rm ~/$ARCH/nodes-web/scripts/build.sh

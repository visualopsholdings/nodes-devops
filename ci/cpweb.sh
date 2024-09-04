
if [ "$#" -lt 2 ]; then
	echo "usage: $0 ARCH FOLDER"
	exit 1
fi

ARCH=$1
FOLDER=$2

rm -rf $FOLDER/$ARCH/nodes-web
mkdir $FOLDER/$ARCH/nodes-web
mkdir $FOLDER/$ARCH/nodes-web/build
mkdir $FOLDER/$ARCH/nodes-web/scripts

get() {
  cp $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

getfolder() {
  cp -r $FOLDER/$1/$2 $FOLDER/$ARCH/$1
}

get nodes-web/build nodes-web

getfolder nodes-web scripts
getfolder nodes-web ssl
getfolder nodes-web frontend

# don't want this.
rm $FOLDER/$ARCH/nodes-web/scripts/build.sh

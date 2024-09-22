#!/bin/bash
# 
# AWS configure script

if [ "$#" -lt 2 ]; then
	echo "usage: $0 HOST EMAIL"
	exit 1
fi

HOST=$1
EMAIL=$2

# get a certificate from letsencrypt
./nodes-web/scripts/new-cert.sh $HOST $EMAIL

# generate an NgINX config
./nodes-web/scripts/nginxconf.sh $HOST 443 80

# setup the mongo DB
./install/mongo.sh

# create start and stop scripts.
cat > startall.sh << EOL
nodes/scripts/start.sh nodes nodes $HOST
nodes-web/scripts/start.sh
nodes-irc/scripts/start.sh
EOL

cat > stopall.sh << EOL
nodes/scripts/stop.sh
nodes-web/scripts/stop.sh
nodes-irc/scripts/stop.sh
EOL

chmod u+x startall.sh
chmod u+x stopall.sh

# Run up our code
./startall.sh

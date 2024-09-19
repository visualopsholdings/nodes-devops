
These are scripts very specific to the build machines. Not really useful in a general context.

## startall.sh

#!/bin/bash
#

echo "Starting it all"

cd /home/visualops

rm nodes*.log

./nodes/scripts/start.sh nodes nodes irc.visualops.com
./nodes-irc/scripts/start.sh
./nodes-web/scripts/start.sh

## stopall.sh

#!/bin/bash
#

nodes-irc/scripts/stop.sh
nodes-web/scripts/stop.sh
nodes/scripts/stop.sh

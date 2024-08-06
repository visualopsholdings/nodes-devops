#!/bin/bash
# 
# Populate the mongo DB.

mongosh << EOF
use nodes
db.createUser(
    {
      user: "nodes",
      pwd: "nodes",
      roles: [
          { role: "readWrite", db: "nodes" }
      ]
    }
)
EOF

cd nodes/mongodb
tar xzf initial.tgz
./restore.sh

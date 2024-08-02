#!/bin/bash
# 

# key and software list for mongodb
echo "deb [ arch=arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -


#!/bin/bash
# 
# Download an ARM build

wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.2.0/aws-t4g-ubuntu-24_04.tgz
tar xzf aws-t4g-ubuntu-24_04.tgz
mv aws-t4g-ubuntu-24_04/nodes-lib .
mv aws-t4g-ubuntu-24_04/nodes .
mv aws-t4g-ubuntu-24_04/nodes-web .
mv aws-t4g-ubuntu-24_04/nodes-irc .
rm -rf aws-t4g-ubuntu-24_04*

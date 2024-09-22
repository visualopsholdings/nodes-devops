#!/bin/bash
# 
# Download an Intel build

wget https://github.com/visualopsholdings/nodes-devops/releases/download/v0.2.0/aws-t2-ubuntu-24_04.tgz
tar xzf aws-t2-ubuntu-24_04.tgz
mv aws-t2-ubuntu-24_04/nodes-lib .
mv aws-t2-ubuntu-24_04/nodes .
mv aws-t2-ubuntu-24_04/nodes-web .
mv aws-t2-ubuntu-24_04/nodes-irc .
rm -rf aws-t2-ubuntu-24_04*

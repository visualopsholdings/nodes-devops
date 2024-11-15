#!/bin/bash
#

pushd ..
aws/upgrade-arm.sh nodestest.visualops.com ~/vopsDev/build/awskey-us-west.pem v0.5.0
popd

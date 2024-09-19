
ssh -i ~/vopsDev/build/awskey-sydney.pem visualops@irc.visualops.com "cd nodes-devops/ci; ./cpall.sh aws-t4g-ubuntu-24_04"
scp -i ~/vopsDev/build/awskey-sydney.pem visualops@irc.visualops.com:aws-t4g-ubuntu-24_04.tgz .

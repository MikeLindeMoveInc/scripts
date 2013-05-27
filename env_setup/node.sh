#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

cd /tmp/env_setup/
wget http://nodejs.org/dist/node-latest.tar.gz
tar xzf node-latest.tar.gz
cd `ls -d */ | grep node-`

./configure
make && make install

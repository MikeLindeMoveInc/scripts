#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

cd /tmp/env_setup
wget ftp://ftp.astron.com/pub/freetds/stable/freetds-stable.tgz
tar xzf freetds-stable.tgz
cd `ls -d */ | grep freetds-`

./configure
make
make install
